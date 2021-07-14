README
================
Lutz Gruber
2021-07-14

This is package serves to demonstrate that `devtools::test()` fails for
function `master_fct2` (when the package is not installed but merely
loaded with devtools), but the function runs without any problems when
called by the user.

It is noteworthy that the problem appears to come from a call to
`dplyr::summarize` in the worker function. `master_fct1` calls a
different worker function that does not use `dplyr::summarize`, and
`devtools::test()` has no problems with that function.

## devtools::test()

``` r
tryCatch(
  expr = { devtools::test() },
  error = function(e) {
    print(conditionMessage(e))
  }
)
```

    ## ℹ Loading demo

    ## ℹ Testing demo

    ## ✓ |  OK F W S | Context
    ## ⠏ |   0       | functions                                                       ⠋ |   1       | functions                                                       ⠹ |   3       | functions                                                       ⠦ |   6 1     | functions                                                       x |   6 1     | functions [2.4 s]
    ## ────────────────────────────────────────────────────────────────────────────────
    ## Error (test_functions.R:20:3): master_fct2 performs as expected
    ## Error: 5 nodes produced errors; first error: there is no package called ‘demo’
    ## Backtrace:
    ##  1. demo::master_fct2(5) test_functions.R:20:2
    ##  2. parallel::clusterApplyLB(cl = cl, x = 1:n, fun = worker_fct2) /home/lutz/demo/R/functions.R:42:2
    ##  3. parallel:::dynamicClusterApply(cl, fun, length(x), argfun)
    ##  4. parallel:::checkForRemoteErrors(val)
    ## ────────────────────────────────────────────────────────────────────────────────
    ## 
    ## ══ Results ═════════════════════════════════════════════════════════════════════
    ## Duration: 2.4 s
    ## 
    ## [ FAIL 1 | WARN 0 | SKIP 0 | PASS 6 ]
    ## 
    ## I believe in you!

## Call function manually

``` r
devtools::load_all()
```

    ## ℹ Loading demo

``` r
master_fct2(5L)
```

    ## [[1]]
    ##   x y
    ## 1 1 1
    ## 
    ## [[2]]
    ##     x   y
    ## 1 1.5 2.5
    ## 
    ## [[3]]
    ##   x        y
    ## 1 2 4.666667
    ## 
    ## [[4]]
    ##     x   y
    ## 1 2.5 7.5
    ## 
    ## [[5]]
    ##   x  y
    ## 1 3 11
