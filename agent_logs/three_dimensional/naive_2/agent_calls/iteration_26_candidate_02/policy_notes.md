# Wake-policy diagnosis and candidate hypothesis

## Evidence read before editing

- The four assigned solver examples are exact repeats of one finite capture:
  score `-0.11372863446239556`, arrival `16.604496T`, distance integral
  `1.99814597L`, and final/minimum distance `0.743958L`. Their observations
  confirm direct uniform still-water initialization at `U_infinity=0`, no
  prewarm, and `237` moving-window shifts.
- Both visual rows show self-propulsion rather than advection. The top-down
  sheet develops an alternating wake by `6T` and retains a coherent
  tail-connected street through capture. The oblique Lambda2 sheet likewise
  shows alternating three-dimensional tail structures and a mildly wavy but
  direct target-crossing arc. There is no sampled failure keyframe: all four
  sheets are byte-identical, so failure comparison is limited to inherited
  completed-rollout summaries.
- Trace reconstruction agrees with the inherited diagnosis. Inside `3L`, the
  phase-demodulated target--velocity alignment averages about `0.928` while
  speed stays about `0.995U`; nevertheless the bounded demodulated yaw-response
  term has mean absolute activation about `0.737` and remains strongly active
  during the already closing approach. The visual wake and bounded loads make
  carrier reduction unjustified.
- Sampled optimizer guidance records that two approach-only inertial
  line-of-sight-rate feedforwards regressed from this parent's score and
  distance integral to `-0.118996/-0.118543` and
  `2.002387/2.001984L`. Target-bearing phase residualization was worse
  (`17.094002T`, `-0.121357`), and a phase-residual yaw-moment rejection scored
  `-0.115946`. Those completed negative results rule out another additive
  direction-rate cue or another correlated-signal residualization here.

## One candidate mechanism

Preserve the complete assigned capture carrier and add one smooth terminal
supervisory release. Below `3L`, only when the phase-demodulated body-frame
velocity is speed-qualified and closely aligned with the body-frame target
vector, reduce the existing demodulated yaw-response contribution by at most
one half. The gate is exactly zero outside `3L`; it does not alter raw bearing,
raw anterior course centering, posterior course or crossflow cues, traveling
wave amplitude/lag, half-cycle semantics, or the one-sided speed guard.

Expected effect: stop an already reliable closing route from continuing to
chase carrier-scale yaw error, while retaining enough response authority for
late correction. Falsify the mechanism if the rollout changes action before
`3L`, loses capture or the tail-connected wake, arrives later, crosses less
deeply, increases distance cost, joint contact, saturation, effort, force, or
moment, or merely transfers oscillation to the remaining fast cue.

A post-edit, non-CFD replay of the completed trace's reconstructed policy
observations confirms exact parent action at and outside `3L` and identical
anterior acceleration everywhere. Of the terminal samples, the posterior
acceleration change has median absolute magnitude about `0.00010 rad/T^2`,
95th percentile `0.0253 rad/T^2`, and maximum `0.710 rad/T^2`; candidate action
remains within the released `1800 deg/T^2` envelope. This is a structural
sanity check only, not evidence of a new trajectory or improvement.

bookshelf_consulted: true
source_domain: closed-loop robotic-fish CPG modulation and terminal capture control
source_mechanism: preserve the rhythmic propulsive carrier while sensed approach state gates a bounded fast correction
transferable_invariant: separate slow route geometry and the traveling carrier from fast response, and release only the fast response when normalized target alignment and forward motion already demonstrate reliable closure
nontransferable_details: published gains, dimensional frequencies, robot linkage kinematics, species envelopes, exact beat or vortex phase, and task-specific routes
policy_translation: inside 3L, form a smooth gate from phase-demodulated body-frame target--velocity alignment and forward-speed qualification, then reduce only the existing yaw-response weight by at most one half
falsification: reject on any pre-3L action change, capture or wake-connectivity loss, worse arrival/crossing/distance cost, increased joint-limit or effort burden, larger force or moment, or unchanged terminal oscillation
