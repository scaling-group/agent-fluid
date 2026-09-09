# Wake-policy candidate notes

## Evidence diagnosis

All four sampled episodes satisfy the direct-uniform still-water contract
(`U_infinity=(0,0,0)`, no prewarm) and capture without instability. The
combined sheets show self-propulsion from a wake-free release, a persistent
alternating mid-plane wake, and coherent oblique Lambda2 structures rather
than advection or wake collapse. The strongest finite sample is the prefilled
range-specific carrier-coupling handoff: it captures at `15.939T`, has distance
integral `1.82008L`, a `13.107L` head path, and peak planar-force/yaw-moment
coefficients `0.03477/0.01715`. The informative redirect-release regression
retains wake coherence but visibly adds a late hook and terminal frames; its
capture is `16.247T`, distance integral `1.82240L`, path `13.363L`, and peaks
`0.03520/0.01783`. Two byte-identical all-distance carrier-release repeats
span `16.071--16.088T`, so their small ordering is repeat variation, while the
prefill recovers the best `4/3/2/1L` milestones.

The common remaining cost is not repaired by changing carrier or redirect
release: all four samples spend `17.50--17.70%` of the episode above 90% of the
anterior joint-rate limit and `11.93--12.18%` above 99%, despite different
terminal paths. The assigned-parent lesson already bounds half-cycle steering
by this actuator cost. Its inherited completed child still captured but scored
only `0.05319`, below the fully observed sampled range `0.05893--0.06189`; the
score-only log cannot support attributing a new mechanism or overriding the
multimodal range-specific handoff evidence.

## Policy hypothesis

Keep the prefilled distance/closing drive relief, velocity-course redirect,
posterior allocation handoff, and range-specific release of negative-work
carrier reversal unchanged. Change only the steering half-cycle allocation:
start with full asymmetry when yaw response is absent, then continuously
reduce it toward the normalized current target-bearing demand when the
commanded yaw response appears. If yaw must be braked, command and measured
yaw have opposite signs, so full half-cycle authority returns without a clock
or hidden mode. This should stop paying full duty-asymmetry cost during
already-aligned middle-field motion while retaining strong correction for a
large target bearing or unfulfilled turn.

Falsify the candidate if it loses capture or the coherent two-view traveling
wake; if `4/3/2/1L` milestones, capture timing, or distance integral regress
beyond the sampled all-distance-repeat spread; or if path, peak force/moment,
mean command, joint margin, or greater-than-90/99%-rate residence fail to
improve enough to justify the added response allocation.

bookshelf_consulted: true
source_domain: closed-loop CPG control of robotic-fish asymmetric flapping
source_mechanism: sensor-feedback modulation of the steering-heavy half-cycle while retaining the propulsive rhythm
transferable_invariant: allocate rhythmic steering to unresolved body-frame direction demand and release excess asymmetry when measured yaw fulfills the request
nontransferable_details: published gains, oscillator frequencies, robot morphology, duty ratios, world-frame routes, and species-specific kinematics
policy_translation: bound the existing joint-phase half-cycle asymmetry by current normalized target bearing and same-sign normalized yaw response; preserve the two-joint carrier, posterior lag, target redirect, and actuator envelope
falsification: reject if timing or distance integral leaves the repeat-supported capture class, wake coherence or joint margin degrades, or command/rate/load/path costs do not improve
