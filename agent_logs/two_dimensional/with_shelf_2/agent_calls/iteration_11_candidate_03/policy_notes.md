# Multi-wake target-policy candidate notes

## Evidence diagnosis before the edit

- The shared prewarm sheet shows the fish held above and downstream of the four
  staggered cylinders while their streets develop and merge through the target
  region. It is the common initial condition for every candidate, not evidence
  that any controller created or selected this wake.
- All four sampled solver sheets are successful and no sampled failure
  keyframe exists. The three strongest samples are byte-identical policies and
  exactly repeat `target_reached` at `45.61`, `1.722L` mean distance, score
  `0.158830`, and `453/4406` force/moment RMS. The distinct weaker sample
  reaches slightly earlier at `45.48` but has `1.724L` mean distance, score
  `0.156386`, and lower `405/4029` loads. Both released sheets show the same
  control topology: a coherent body-generated traveling wake, active diagonal
  upstream/downward propulsion, a broad bend into the interacting wake field,
  and capture from the right. The nearly indistinguishable six-frame paths do
  not resolve beat-scale cause, so the force, distance, and policy differences
  bound the inference.
- Metrics confirm self-propulsion rather than passive downstream advection: the
  strongest candidate averages `-0.241L/time` in x while its local flow
  averages `-0.174`; its relative crossflow RMS is `0.291`. The course-trend
  residual improves mean distance by only `0.0023L` over the simpler normalized
  closure policy while raising force/moment RMS by `48/377`, and every sampled
  success still touches both `4.538 rad/time` joint-rate caps.
- The assigned parent's inherited aligned phase-lag candidate is an informative
  finite regression rather than a failure keyframe: it preserves the diagonal
  capture sheet but arrives at `46.22`, worsens mean distance to `1.735L` and
  score to `0.146573`, and raises mean command energy to `1036`. Its lower
  `424/4253` loads do not compensate for worse useful closure. The older
  propulsive-priority allocator is the semantic failure boundary: it passed
  below capture and collided at `58.93` after a `1.872L` closest approach with
  `537/4995` loads. These results reject further phase/amplitude escalation or
  broad steering-to-propulsion reallocation.

## Policy hypothesis

Preserve the successful zero-centered oscillator, posterior lag, predicted-
bearing half-cycle steering, yaw-moment steering gate, smooth limiter, and the
small course-consistent positive-closure residual. Add one scale-free wake-
event allocator only to that residual: compute the fraction of measured
body-frame relative-flow energy that is streamwise, and let crossflow-dominated
events continuously suppress the extra progress-earned posterior emphasis.
The base traveling wave, fixed alignment emphasis, and target-steering command
remain unchanged, so lateral wake motion is neither treated as a route command
nor indiscriminately cancelled.

The candidate is falsified if it loses target capture or the established
diagonal topology, fails to reduce the current `453/4406` load increase without
giving back the course-trend distance benefit, or increases cap contact,
arrival time, or distance history. Because no sign-resolved event history is
available, the allocator uses relative-flow axiality only; adding a signed
crossflow steering residual is explicitly outside this test.

bookshelf_consulted: true
source_domain: multi-cylinder wake interaction and sensor-modulated robotic-fish rhythmic control
source_mechanism: preserve a useful propulsive rhythm while separating slow target steering from bounded response to fast lateral wake events
transferable_invariant: protect the base traveling wave and allocate only optional propulsion residual when observed body-frame relative flow is axial rather than crossflow-dominated
nontransferable_details: published gains, species-specific kinematics, dimensional frequencies, exact vortex phases, cylinder coordinates, and task-specific routes
policy_translation: multiply only the course-consistent positive-closure posterior residual by the scale-free streamwise fraction of local relative-flow energy, leaving the two-joint gait and steering law intact
falsification: reject if capture or diagonal upstream propulsion is lost, or if loads, saturation, arrival, or distance history fail to improve relative to the course-consistency parent
