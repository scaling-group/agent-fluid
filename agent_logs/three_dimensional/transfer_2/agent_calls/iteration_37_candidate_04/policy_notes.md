# Course-resolved predictive carrier governor

## Visual diagnosis before editing

- All four sampled rollouts satisfy the frozen evidence contract: direct
  uniform `U_infinity=(0,0,0)` initialization, zero cylinders, no prewarm,
  finite moving-window transport, stable dynamics, and `capture`. Because no
  semantic failure is present, the informative failure is the slower,
  longer-path response-residual sample `solver_f997a0c1ad0f` relative to the
  strongest finite sample `solver_674e84ea2575` and the assigned-parent
  response-released sample `solver_0e3ccca5bc77`.
- I inspected both rows of the combined keyframe sheets for the strongest and
  informative-failure samples from release through capture. In both top-down
  rows the fish turns and advances under its own motion from blank still water,
  shedding a compact alternating caudal vortex street rather than drifting or
  flailing. The oblique rows show discrete three-dimensional Lambda2
  structures trailing the caudal region throughout the shallow target arc.
  Neither view shows wake collapse, collision, domain exit, or instability;
  preserve the traveling carrier, body-frame target sign, course redirect, and
  approach drive relief.
- The sampled joint-state preview is the useful differentiator. Relative to
  the assigned parent, it improved score from `0.06072` to `0.07224`, capture
  from `16.088T` to `15.851T`, distance integral from `1.82203L` to
  `1.81025L`, and head path from `13.129L` to `12.995L`. Anterior residence
  above 90/99% of the hard rate fell from `17.50/11.93%` to `17.18/9.16%`;
  posterior residence fell from `7.93/1.44%` to `6.52/0.00%`, and mean command
  fell from `16.52/15.31` to `16.21/14.89 rad/T^2`. This directly supports
  retaining the phase-space lookahead rather than lowering a scalar onset.
- The boundary is hydrodynamic load and response semantics. The preview
  sample's planar-force/yaw-moment peaks rose to `0.03846/0.01908` from the
  assigned parent's `0.03575/0.01781`, so it is not established load relief.
  Inherited logs also show that instantaneous force/moment carrier relief
  delayed capture and barely changed peaks, so do not repeat that gate. The
  response-residual sample captured later at `16.247T`, lengthened path to
  `13.363L`, and raised mean command without material actuator or load relief;
  same-sign yaw alone therefore does not prove that a velocity-course redirect
  is fulfilled.

## One-candidate policy hypothesis

Start from the sampled predictive positive-work governor and make one compact
state-feedback change to its approach carrier transition. Preserve the far
response release. As the existing normalized distance handoff advances,
restore negative-work carrier reversal only in proportion to resolution of the
measured body-frame velocity-course redirect: a small redirect magnitude
passes reversal, while a large unresolved course error retains redirect
priority. Keep positive-work preview attenuation, target-conditioned steering,
and every propulsion parameter unchanged. The working test is whether
course-resolved release preserves the compact alternating wake while avoiding
the later-path regression seen in the response-residual sample.

Expected signature: retain capture, early milestones, reduced greater-than-99%
rate residence, lower mean command, and coherent two-view wake while avoiding
the fixed-handoff late hook and the same-sign-yaw residual regression. A useful
result should shorten or reshape the approach beyond repeat variation without
raising the preview sample's force/moment peaks. Falsify if capture or early
progress is lost; path/integral, command, joint-rate residence, joint margin,
terminal course, or loads regress; or either wake row loses coherence.

bookshelf_consulted: true
source_domain: biological C-start redirect and sensor-modulated robotic-fish CPG control
source_mechanism: retain strong redirect priority until measured locomotor response resolves the directional demand, then release continuously into the phase-coupled traveling rhythm
transferable_invariant: govern the redirect-to-rhythm transition with normalized observed response rather than elapsed time, fixed route, or target distance alone
nontransferable_details: species-specific C-start shapes, published CPG gains, dimensional timing, full-body kinematics, exact vortex phase, and task coordinates or routes
policy_translation: preserve the proven joint-state positive-work preview and multiply approach reversal release by resolution of the bounded body-frame velocity-course redirect, while leaving target steering and the two-joint traveling carrier unchanged
falsification: reject if capture, early milestones, rate relief, integral or path beyond repeat spread, command, joint margin, terminal course, force or moment peaks, finite action, or coherent top-down and oblique wakes regress
