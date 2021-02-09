# shinysse
'shinysse' is an R package containing a modular shiny app that demonstrates sample size estimation.

This app is a work in-progress and is currently not validated. Furthermore, it is for demonstration purposes only by design, and cannot replace a well crafted statistical modelling performed by a skilled statistician.

To run the app localy on your computer:

## Install shinysse  
Install from GitHub with 'devtools'  

 `devtools::install_github("https://github.com/CTU-Basel/shinysse")`


## Run shinysse app
Run the app localy on your computer after installation       

`shinysse::run_shiny()`

To run the app on the shiny site connect to:
https://dkfbasel.shinyapps.io/shinysse/

## For contributors

### Linting

Lint with the 'lintr' package

```
# lint the package -> should be clean
library(lintr)
lint_package("shinysse", linters = with_defaults(camel_case_linter = NULL,
                                                 object_usage_linter = NULL,
                                                 line_length_linter(125)))
```
