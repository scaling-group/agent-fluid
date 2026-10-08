# Wake-policy candidate notes

## Inherited and sampled evidence

- All four sampled rollouts satisfy the frozen initialization contract:
  direct uniform `U_infinity=(0,0,0)`, no cylinders, and no prewarm. Motion in
  both visual rows is therefore self-propelled rather than ambient advection.
- The top-down sheets show a coherent alternating signed-vorticity wake during
  broad approach, and the oblique sheets confirm persistent three-dimensional
  Lambda2 structures. The two continuously beating approach variants retain
  this wake through roughly `18T`, but still pass high and exit the upper
  boundary; their closest distances are `3.162L` and `3.032L`.
- The full-quadrant distributed-bend sample is a direct test of the assigned
  parent's active-redirect premise. It preserves the common trajectory through
  about `14T` and reaches `2.999L`, but does not beat the inherited unrelieved
  bearing/slip result (`2.960L`) or improve the `left_domain` termination. Its
  oblique row and trace then show a stalled curved posture and inertial coast:
  after `18T`, both mean absolute joint rates are about `0.001 rad/T`, and
  `100%` of samples have both joint rates below `0.05 rad/T`. The fish curls
  upward and exits at center `y=15.202L`.
- The distance-conditioned joint hold supplies the same boundary more mildly:
  after `18T` its mean joint rates fall to `0.023/0.016 rad/T`, it misses at
  `3.592L`, and it exits sooner at center `y=15.204L`. By contrast, the two
  beating variants retain anterior mean rate near `2.62 rad/T`. The evidence
  therefore rejects damping or equilibrium shifting that turns a redirect
  into a static posture; freed reserve and a bent body are not corrective
  authority without continued hydrodynamic cycling.
- Earlier inherited logs also report that posterior opposing-half-cycle relief
  applied throughout target turning reached only `9.855L`. Any phase-aware
  asymmetry must consequently be confined to the established close,
  misaligned approach and must recover the unmodified carrier when the fish is
  far, aligned, or no longer closing.

## Policy hypothesis

Restore the demonstrated zero-centered anterior oscillator and full posterior
carrier outside a smooth state gate. During a close, misaligned, still-closing
pass, infer posterior beat side from the lagged joint-state carrier. Preserve
the half-cycle aligned with the bounded target-relative turn request and
attenuate only the opposing half-cycle. This creates bounded duty/amplitude
asymmetry without an anterior mean shift, added damping, a clock, or a hidden
mode. Full-quadrant `target_body_L` supplies the target direction, while the
measured closing response releases the asymmetry at closest approach instead
of allowing another static coast.

The candidate should reproduce the sampled carrier through the far field,
retain visible alternating shedding and nonzero joint rates during correction,
and redirect before the high pass. Falsify it if the trajectory changes before
the close/misaligned gate, either joint settles into a static posture, closest
distance does not improve below `2.960L`, posterior limit occupancy worsens
materially, or the same upper exit persists without a distinct recovery arc.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and sensor-modulated CPG direction tracking
source_mechanism: observed direction error changes the relative strength or duty of the two beat half-cycles while the propulsive rhythm continues
transferable_invariant: derive beat side from joint state, preserve a traveling carrier, and apply bounded target-relative asymmetry only while measured geometry and closing response require correction
nontransferable_details: published gains, dimensional switch distances, clock phase, species-specific amplitudes, exact vortex phases, and task-specific routes
policy_translation: combine normalized full-quadrant `target_body_L`, body-frame slip, normalized distance, and measured closing speed into a smooth gate; use the sign of the lagged posterior carrier relative to the turn request to relieve only the opposing half-cycle
falsification: reject if far-field motion changes, active correction loses alternating wake or joint cycling, target-normal miss fails to beat `2.960L`, demand becomes more limit-heavy, or termination remains the same without a meaningfully different trajectory
