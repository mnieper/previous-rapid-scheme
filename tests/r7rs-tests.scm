(import (scheme base)
	(rapid test)
	(rename (rapid test test) (run-tests run-rapid-test-tests)))

(run-rapid-test-tests)

(test-begin "R7RS")

(test-end)
