# Multi-wake target-policy diagnosis and hypothesis

## Evidence diagnosis before the policy edit

- The assigned parent guidance contains the seed's durable negative result, and
  its inherited optimizer logs add three relevant failures. A bearing-rate
  controller with the opposite curvature sign became unstable after `1.66`
  released units; a full phase-radius oscillator with positive bearing and yaw
  damping was almost exactly advected by the local flow and exited lower-right;
  and a slower `15 deg` angle-only oscillator with yaw damping and a `1000
  deg/time^2` soft limit also went downstream, leaving after `10.02` units with
  `-0.168` progress. These results do not isolate yaw damping, but they rule out
  weakening or phase-radius-regulating the propulsive gait as the next repair.
- The shared prewarm sheet shows the common held fish above and downstream of
  the four staggered cylinders while developed vortex streets cross the target
  corridor. This is common initial-condition evidence, not a controller effect;
  every sampled fish fails before reaching that useful wake region.
- The strongest finite sampled mechanism is the `0.75`-period, `22 deg`
  angle-only oscillator with positive body-frame bearing curvature. Its released
  sheet shows active upstream motion before a sharp turn and folded terminal
  shape. The metrics agree: head displacement `(-3.59,+0.15)L`, progress
  `0.259`, and mean velocity x `-0.149` versus local-flow x `-0.077` demonstrate
  self-propulsion, but both acceleration commands touch `1800 deg/time^2`, joint
  1 touches the speed cap, RMS force/moment reach `20023.6/314391`, and the run
  ends as `unstable_dynamics` at `33.06` units.
- The current prefilled guarded descendant is the most informative comparison.
  Its sheet shows an initially leftward segment followed by a large curling
  path, reversal, and upward boundary exit rather than wake entry. It remains
  finite for `63.55` units and stays below the acceleration caps, but finishes
  with head displacement `(+0.43,+1.80)L`, minimum/final range
  `10.35/13.54L`, and `-0.090` progress. Mean velocity `(0.0017,0.0189)` and
  local flow `(0.0093,0.0122)` confirm that the closed turn cancels the useful
  initial upstream component. The present steering map divides bearing by its
  `12 deg` limit inside `tanh`, so it remains nearly saturated through ordinary
  course errors; reduced cap contact therefore bought stability but not
  directional control.
- The other sampled positive-bearing/yaw-damped phase-radius policy is a clean
  negative boundary: low loads and sub-cap action accompany downstream/lower
  exit, `(+2.27,-4.79)L` head motion, and mean velocity nearly identical to
  local flow. Stability and low effort cannot be treated as evidence of useful
  propulsion.

## One candidate hypothesis

Keep the prefilled `0.80`-period, `22 deg` angle-only oscillator, posterior lag,
joint guards, and high-order acceleration soft bound unchanged, because that
combination is the longest finite sampled angle-only rollout and visibly
retains an initial leftward segment. Change only the course command: map
positive body-frame bearing through `tanh` on a radian-scale input rather than
dividing by the small curvature limit, and oppose measured body turn rate in
the same bounded request. This preserves a near-limit initial turn for the
large release error, then progressively unloads mean curvature as bearing
shrinks and during rapid yaw, without using coordinates, time, a route, or an
unavailable flow probe.

The next CFD rollout supports the hypothesis only if it avoids the prefilled
large loop, preserves a negative streamwise velocity component relative to the
local flow, adds target-directed lateral travel, and remains finite and
in-domain beyond `63.55` units without hard cap contact. It is falsified by
another upper or lower boundary curl, loss of the initial upstream segment,
folding/instability, or unchanged negative distance progress. No evaluation
outcome for this candidate is claimed here.
