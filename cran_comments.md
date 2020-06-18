cran-comments.md
================
Joel Pointon
16/06/2020

## Test environments

  - local Windows 10 install, R 3.6.3

## R CMD check results

-- R CMD check results ---------------------------------- Kenometrics 0.1.0 ----
Duration: 1m 25.3s

0 errors v | 0 warnings v | 0 notes v

R CMD check succeeded

## Downstream dependencies

I have also run R CMD check on downstream dependencies of httr
(<https://github.com/wch/checkresults/blob/master/httr/r-release>). All
packages that I could install passed except:

  - Ecoengine: this appears to be a failure related to config on that
    machine. I couldn’t reproduce it locally, and it doesn’t seem to be
    related to changes in httr (the same problem exists with httr 0.4).
