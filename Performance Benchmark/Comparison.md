| Benchmark                                                                  	| R      	| Julia 	| ratio 	|
|----------------------------------------------------------------------------	|--------	|-------	|-------	|
| Logit Regression Permutation Hypothesis Test                               	| 143.98 	| 25.66 	| 5.61  	|
| Generating New Variable of 100 Thousand Observations w/ for-loop           	| 0.35   	| 0.14  	| 2.52  	|
| Generating a Dataset of 10 Million Observations                            	| 3.65   	| 0.45  	| 8.10  	|
| Generating New Variable of 10 Million Observations w/o for-loop            	| 1.16   	| 0.09  	| 13.42 	|
| Merging a Dataset of 10 Million Observations on 1 Key                      	| 19.16  	| 1.36  	| 14.06 	|
| Merging a Dataset of 10 Million Observations on 2 Keys                     	| 31.76  	| 1.54  	| 20.61 	|
| Applying a function with multiple inputs to a dataset of 10 million values 	| 21.76  	| 0.30  	| 71.79 	|
| Monte Carlo Sensitivity Analysis                                           	| 9.71   	| 1.35  	| 7.20  	|
