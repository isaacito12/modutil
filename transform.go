package main

import (
	"fmt"
	"os"
	"regexp"
	"strings"
)

func main() {
	if len(os.Args) < 3 {
		fmt.Fprintf(os.Stderr, "Usage: %s <input.html> <output.html>\n", os.Args[0])
		os.Exit(1)
	}

	data, err := os.ReadFile(os.Args[1])
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error reading file: %v\n", err)
		os.Exit(1)
	}

	html := string(data)

	html = fixCSSFonts(html)
	html = injectCSS(html)
	html = stripInlineStyles(html)
	html = removeJustificationColumns(html)
	html = wrapCodeTablesInDetails(html)
	html = highlightUncoveredLines(html)

	err = os.WriteFile(os.Args[2], []byte(html), 0644)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error writing file: %v\n", err)
		os.Exit(1)
	}

	fmt.Printf("Done. %s (%d bytes) -> %s (%d bytes)\n",
		os.Args[1], len(data), os.Args[2], len(html))
}

func fixCSSFonts(html string) string {
	// Replace Cambria (serif) with Segoe UI (sans-serif) in h1-h6 CSS rules
	html = strings.ReplaceAll(html,
		"font-family: Cambria, 'Noto Sans', 'Noto Sans CJK JP', 'Noto Sans CJK SC', 'Noto Sans CJK KR';",
		"font-family: 'Segoe UI', 'Noto Sans', 'Noto Sans CJK JP', 'Noto Sans CJK SC', 'Noto Sans CJK KR', sans-serif;")

	// Ensure body and table use a clean sans-serif stack
	html = strings.ReplaceAll(html,
		"font-family: 'Noto Sans', 'Noto Sans CJK JP', 'Noto Sans CJK SC', 'Noto Sans CJK KR';",
		"font-family: 'Segoe UI', 'Noto Sans', 'Noto Sans CJK JP', 'Noto Sans CJK SC', 'Noto Sans CJK KR', sans-serif;")

	return html
}

func injectCSS(html string) string {
	newCSS := `
  /* Accordion for code tables */
  details { margin: 8px 0; }
  details summary {
    cursor: pointer;
    font-weight: bold;
    font-size: 11pt;
    padding: 4px 0;
    color: rgb(79,129,189);
  }
  details summary:hover { text-decoration: underline; }

  /* Highlight uncovered lines */
  tr.uncovered > td { background-color: #ffdddd; }

  `
	// Insert before the closing of the style block
	html = strings.Replace(html, "/*]]>*/</style>", newCSS+"/*]]>*/</style>", 1)
	return html
}

func stripInlineStyles(html string) string {
	// Remove the repeated inline font-family declaration from body content
	// This pattern appears thousands of times in spans, divs, and paragraphs
	inlineFont := `font-family:'Sans-Serif', 'Noto Sans', 'Noto Sans CJK JP', 'Noto Sans CJK KR', 'Noto Sans CJK SC', 'Noto Emoji';`
	html = strings.ReplaceAll(html, inlineFont, "")

	// Remove font-size:12pt where it's the default body size (only in inline styles)
	// Be careful: only remove from style attributes, not from the <style> block
	// Target: within style="..." attributes that had the font-family removed
	re := regexp.MustCompile(`(style="[^"]*?)font-size:12pt;`)
	for re.MatchString(html) {
		html = re.ReplaceAllString(html, "${1}")
	}

	// Clean up empty or near-empty style attributes
	// style="" or style=" " can be removed entirely
	reEmpty := regexp.MustCompile(`\s*style="[\s;]*"`)
	html = reEmpty.ReplaceAllString(html, "")

	return html
}

func removeJustificationColumns(html string) string {
	html = removeOverallSummaryJustified(html)
	html = removeTOCJustified(html)
	html = removePerFileSummaryJustified(html)
	html = removeCodeTableJustification(html)
	return html
}

func removeOverallSummaryJustified(html string) string {
	// The Overall Summary table has columns: Coverage Metric | Executable | Missed | Justified | Coverage %
	// Remove the 4th column (index 3) from every row.
	summaryStart := strings.Index(html, `<span style="font-weight:bold;white-space:pre-wrap;">Coverage Metric</span>`)
	if summaryStart == -1 {
		return html
	}
	tableStart := strings.LastIndex(html[:summaryStart], "<table")
	tableEnd := strings.Index(html[tableStart:], "</table>")
	if tableEnd == -1 {
		return html
	}
	tableEnd += tableStart + len("</table>")

	table := html[tableStart:tableEnd]

	reRow := regexp.MustCompile(`<tr[^>]*>.*?</tr>`)
	table = reRow.ReplaceAllStringFunc(table, func(row string) string {
		return removeNthTd(row, 3)
	})

	html = html[:tableStart] + table + html[tableEnd:]
	return html
}

func removeTOCJustified(html string) string {
	// Find the TOC table by "Source File" header
	tocMarker := `<span style="font-weight:bold;white-space:pre-wrap;">Source File</span>`
	tocStart := strings.Index(html, tocMarker)
	if tocStart == -1 {
		return html
	}

	tableStart := strings.LastIndex(html[:tocStart], "<table")
	tableEnd := strings.Index(html[tableStart:], "</table>")
	if tableEnd == -1 {
		return html
	}
	tableEnd += tableStart + len("</table>")

	table := html[tableStart:tableEnd]

	// Change colspan="4" to colspan="3" (Function and Statement group headers)
	table = strings.ReplaceAll(table, `colspan="4"`, `colspan="3"`)

	// Process each row to remove Justified columns
	reRow := regexp.MustCompile(`<tr[^>]*>.*?</tr>`)
	rowNum := 0
	table = reRow.ReplaceAllStringFunc(table, func(row string) string {
		rowNum++
		if rowNum == 1 {
			// First row: Source File | Function (colspan) | Statement (colspan)
			// No justified cells here, colspan already fixed
			return row
		}
		if rowNum == 2 {
			// Sub-header row: [empty] | Exec | Missed | Justified | Cov% | Exec | Missed | Justified | Cov%
			// Remove positions 3 and 7 (0-indexed) — but after removing 3, position 7 becomes 6
			row = removeNthTd(row, 3) // Remove first "Justified"
			row = removeNthTd(row, 6) // Remove second "Justified" (was at 7, now at 6)
			return row
		}
		// Data rows: [link] | e | m | j | c | e | m | j | c  (9 cells)
		// Remove positions 3 and 7 (adjusted after first removal)
		row = removeNthTd(row, 3)
		row = removeNthTd(row, 6)
		return row
	})

	html = html[:tableStart] + table + html[tableEnd:]
	return html
}

func removePerFileSummaryJustified(html string) string {
	// Per-file summary tables (width:10in) contain text like:
	// <span>Justified</span><span>: 0\n</span>
	// Remove these lines
	reJustified := regexp.MustCompile(`<span[^>]*>Justified</span><span[^>]*>: \d+\n</span>`)
	html = reJustified.ReplaceAllString(html, "")
	return html
}

func removeCodeTableJustification(html string) string {
	// Code tables have "Justification" as the last (5th) column header.
	// Find each code table and remove the last td from every row.

	// Split HTML at each code table header occurrence
	marker := `<span>Justification</span></td></tr>`
	parts := strings.Split(html, marker)
	if len(parts) <= 1 {
		return html
	}

	var result strings.Builder
	for i, part := range parts {
		if i == 0 {
			// Remove the Justification header cell from the header row
			// The header td pattern ends with: <td style="..."><span>Justification</span></td></tr>
			// We need to remove the last <td...> before the marker
			lastTdStart := strings.LastIndex(part, "<td style=\"border-bottom-style:dashed;border-bottom-color:#808080;border-bottom-width:0.1px;\"><span>Justification</span>")
			if lastTdStart == -1 {
				// Try without the exact match — find last <td containing Justification
				lastTdStart = strings.LastIndex(part, "<td")
				if lastTdStart != -1 && strings.Contains(part[lastTdStart:], "Justification") {
					part = part[:lastTdStart]
				}
			} else {
				part = part[:lastTdStart]
			}
			result.WriteString(part)
			result.WriteString("</tr>") // Close the header row
			continue
		}

		// For subsequent parts, we need to:
		// 1. Remove Justification header at the END of this part (if not the last part)
		// 2. Remove the last <td> from each data row within this code table

		// Find where this code table ends (next </table>)
		tableEndIdx := strings.Index(part, "</table>")
		if tableEndIdx == -1 {
			result.WriteString(part)
			continue
		}

		tableContent := part[:tableEndIdx]
		afterTable := part[tableEndIdx:]

		// Remove last td from each row in the code table content
		reRow := regexp.MustCompile(`<tr>.*?</tr>`)
		tableContent = reRow.ReplaceAllStringFunc(tableContent, func(row string) string {
			return removeLastTd(row)
		})

		// If not the last part, we also need to handle the next Justification header
		if i < len(parts)-1 {
			// Find and remove the Justification header td at the end of afterTable
			lastTdStart := strings.LastIndex(afterTable, "<td style=\"border-bottom-style:dashed;border-bottom-color:#808080;border-bottom-width:0.1px;\"><span>Justification</span>")
			if lastTdStart != -1 {
				afterTable = afterTable[:lastTdStart] + "</tr>"
			} else {
				// Fallback: look for <td...>..Justification..</td></tr> pattern at the end
				reLast := regexp.MustCompile(`<td[^>]*><span>Justification</span></td></tr>\s*$`)
				loc := reLast.FindStringIndex(afterTable)
				if loc != nil {
					afterTable = afterTable[:loc[0]] + "</tr>"
				}
			}
		}

		result.WriteString(tableContent)
		result.WriteString(afterTable)
	}

	return result.String()
}

func wrapCodeTablesInDetails(html string) string {
	// Code tables follow the per-file summary tables.
	// Pattern: summary table ends with </table>, then immediately a code table starts with <table
	// The code tables are identified by having "Line" "Function" "Statement" "Source Code" as headers.
	// They appear right after per-file summary tables (width:10in).

	// Strategy: find each code table (the one with Line|Function|Statement|Source Code columns)
	// and wrap it in <details><summary>Source Lines</summary>...</details>

	// Code tables have width:18in and their first row contains "Line", "Function", "Statement", "Source Code"
	// They follow immediately after a </table> (the summary table)

	// Find pattern: </table><table align="center" style="width:18in;..."> where the table has Line/Function/Statement/Source Code
	reCodeTable := regexp.MustCompile(`(</table>)(<table align="center" style="width:18in;[^"]*">(?:<tr>)?<td[^>]*><span>Line</span></td>)`)

	html = reCodeTable.ReplaceAllStringFunc(html, func(match string) string {
		loc := reCodeTable.FindStringSubmatchIndex(match)
		closingTable := match[loc[2]:loc[3]]
		tableStart := match[loc[4]:loc[5]]
		return closingTable + `<details><summary>Source Lines</summary>` + tableStart
	})

	// Now close each <details> after the code table's </table>
	// We need to find the </table> that corresponds to each code table we just wrapped
	// Strategy: find each "<details><summary>Source Lines</summary><table" and add "</details>" after its "</table>"
	detailsMarker := `<details><summary>Source Lines</summary><table`
	parts := strings.Split(html, detailsMarker)
	if len(parts) <= 1 {
		return html
	}

	var result strings.Builder
	result.WriteString(parts[0])
	for i := 1; i < len(parts); i++ {
		// Find the first </table> in this part
		tableEnd := strings.Index(parts[i], "</table>")
		if tableEnd != -1 {
			endPos := tableEnd + len("</table>")
			result.WriteString(detailsMarker)
			result.WriteString(parts[i][:endPos])
			result.WriteString("</details>")
			result.WriteString(parts[i][endPos:])
		} else {
			result.WriteString(detailsMarker)
			result.WriteString(parts[i])
		}
	}

	return result.String()
}

func highlightUncoveredLines(html string) string {
	// In code tables, find rows where the Statement column (3rd td) contains <span>0</span>
	// The Statement cell pattern: <td...><p...><span>0</span></p></td>
	// Add class="uncovered" to the <tr>

	// Match a <tr> that contains: 1st td (line#), 2nd td (function count), 3rd td with <span>0</span>
	// The 3rd td is the Statement column
	reRow := regexp.MustCompile(`<tr>(<td[^>]*><span>\d+</span></td>` + // Line number
		`<td[^>]*><p[^>]*><span>[^<]*</span></p></td>` + // Function column
		`<td[^>]*><p[^>]*><span>0</span></p></td>)`) // Statement = 0

	html = reRow.ReplaceAllString(html, `<tr class="uncovered">${1}`)

	return html
}

// removeNthTd removes the nth (0-indexed) <td>...</td> from a table row string.
func removeNthTd(row string, n int) string {
	tdCount := 0
	i := 0
	for i < len(row) {
		tdStart := strings.Index(row[i:], "<td")
		if tdStart == -1 {
			break
		}
		tdStart += i

		if tdCount == n {
			// Find the end of this td: </td>
			tdEnd := strings.Index(row[tdStart:], "</td>")
			if tdEnd == -1 {
				break
			}
			tdEnd += tdStart + len("</td>")

			// Also remove border-right from the previous td (now becomes last before removed)
			// Actually, just remove the td
			row = row[:tdStart] + row[tdEnd:]
			return row
		}

		// Skip past this td
		tdEnd := strings.Index(row[tdStart:], "</td>")
		if tdEnd == -1 {
			break
		}
		i = tdStart + tdEnd + len("</td>")
		tdCount++
	}
	return row
}

// removeLastTd removes the last <td>...</td> from a table row string.
func removeLastTd(row string) string {
	lastTdStart := strings.LastIndex(row, "<td")
	if lastTdStart == -1 {
		return row
	}
	lastTdEnd := strings.Index(row[lastTdStart:], "</td>")
	if lastTdEnd == -1 {
		return row
	}
	lastTdEnd += lastTdStart + len("</td>")

	// Remove the border-right-style from the new last td (the Source Code td)
	beforeRemoved := row[:lastTdStart]
	afterRemoved := row[lastTdEnd:]

	// Find the previous (now-last) td and remove its right border
	prevTdStart := strings.LastIndex(beforeRemoved, "<td")
	if prevTdStart != -1 {
		prevTdEnd := len(beforeRemoved)
		prevTd := beforeRemoved[prevTdStart:prevTdEnd]
		prevTd = strings.Replace(prevTd, "border-right-style:solid;border-right-width:0.1px;", "", 1)
		beforeRemoved = beforeRemoved[:prevTdStart] + prevTd
	}

	return beforeRemoved + afterRemoved
}
