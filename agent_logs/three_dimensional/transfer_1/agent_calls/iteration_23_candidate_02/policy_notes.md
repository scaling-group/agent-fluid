# Candidate wake-policy notes

## Evidence diagnosis

- The assigned v38 parent is no longer a one-run result: three sampled
  direct-uniform still-water evaluations have byte-identical trajectories and
  reproduce capture at `18.23249 T`, score `-0.12650`, with distances
  `11.6583/8.9925/5.8275/2.4288 L` near `4/8/12/16 T`.  Its combined sheet
  shows active self-propulsion on a smooth target-directed arc, a coherent
  alternating top-down vortex street, and compact paired oblique Lambda2
  structures through capture.  Mean/max speed is `0.7032/0.9519 L/T`, peak
  normalized force/moment is `0.03068/0.01579`, and either-joint acceleration
  saturation occupies about `41.54%` of samples.  Initialization is explicitly
  uniform direct with `U_infinity=(0,0,0)` and no cylinders.
- The informative v39 comparator preserves capture and the same visible wake
  topology but unions lateral-load magnitude with the v38 crossflow confidence.
  It crosses `0.0330 T` earlier and is `0.0080/0.0102 L` closer near `4/16 T`,
  yet it is `0.0422/0.0385 L` farther away near `8/12 T`, increases the raw
  distance-time integral from `139.9126` to `140.1889 L*T`, raises max speed
  from `0.9519` to `0.9613 L/T`, and scores lower at `-0.12947`; peak force is
  unchanged and peak moment/saturation improve only slightly.  Offline
  reconstruction shows why: lateral-load confidence averages `0.8970`, so its
  soft union makes confidence almost always active (`0.9792` mean) instead of
  preserving the parent's band-pass crossflow confidence (`0.7845` mean).
  Thus load magnitude is not complementary evidence of gait-pose certainty in
  this coherent still-water wake.

## Policy hypothesis

Preserve the entire v38 carrier, route feedback, crossflow band-pass, and
actuator allocation.  Add lateral load only as bounded extra confidence while
normalized measured closure is absent or weak, then continuously release that
extra channel as positive closing response establishes.  Reconstructed
response gating raises mean confidence only during `0-4 T` (where v39 had its
small early lead) and is effectively identical to v38 from `4 T` onward, where
the ungated union accumulated its middle-route deficit.  This tests
response-arbitrated sensor augmentation rather than another carrier or scalar
gain adjustment.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and adaptive wake interaction
source_mechanism: retain a stable traveling-wave carrier while a bounded sensor residual yields when the desired motion response appears
transferable_invariant: separate persistent body-frame target guidance from fast hydrodynamic confidence, and release extra confidence using observed task response rather than time or route position
nontransferable_details: published gains, species and robot kinematics, exact vortex phase, dimensional frequencies, and task-specific routes
policy_translation: soft-union normalized lateral-load confidence with the existing body-frame crossflow band-pass only while normalized closing response is unproductive; confine the result to proportional gait-pose rejection
falsification: reject if capture, the 8/12 T route lead, or coherent two-view wake is lost, or if distance integral, speed, saturation, force, or moment exceeds the reproduced v38 envelope without a compensating closure gain

## Evaluation boundary

The new candidate has not been evaluated in this worker.  Its intended signature
is an early lead without the v39 middle-route deficit, followed by v38-like
closure, wake coherence, and loads.  Later workers should distrust the mechanism
if the closing gate merely phase-shifts the same deficit or if load confidence
remains active during already productive closure.
