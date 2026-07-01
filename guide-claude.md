# guide

The `Devel` folder structure has been updated so that all MATLAB namespace folders
are put under the `mus1` folder.
For example, `Devel > +AppUtil1` is now `Devel > +mus1 > +AppUtil`,
`Devel > +CodeUtil1` is now `Devel > +mus1 > +CodeUtil`, and so on.
These changes are committed in git.

The next goal is to update the impacted files in the folder where this file exists
because some of them accesses the `Devel` folder and the code may not work any more.

Identify files that need update according to the new `Devel` folder tree and report.
Save the result in "impact-top.md" file.

Do not modify any files and folders.
