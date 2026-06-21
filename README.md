# fm_index
**Version: 0.04**

Formally verified Ada SPARK implementation of the FM-Index backward search (get_rows) algorithm using the Burrows-Wheeler Transform. Based on Paolo Ferragina's methodology. Uses SPARK contracts to guarantee absence of runtime errors and strict index bounds for high-integrity, safety-critical string matching.

## Version History
- **0.04** (2024-06-21): Strengthened preconditions to prevent range check overflows
- **0.03** (2024-06-21): Fixed SPARK quantifier syntax in preconditions
- **0.02** (2024-06-21): Added SPARK preconditions and loop invariants for verification
- **0.01** (2024-06-21): Initial version with version control implementation
