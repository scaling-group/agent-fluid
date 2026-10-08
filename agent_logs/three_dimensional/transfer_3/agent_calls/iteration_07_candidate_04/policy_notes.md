# Coupled phase-entry and response-release candidate

## Evidence diagnosis before the policy edit

- All four sampled rollouts satisfy the frozen physical contract: direct
  uniform still-water initialization with `U_infinity=(0,0,0)`, no cylinders
  or prewarm, finite dynamics, and capture near `25.11T`. The assigned-parent
  response-release policy is reproduced exactly by
  `solver_89a97c83567b` and `solver_b79884a946b7`: both score
  `-0.5283387731`, capture at `25.11852T`, and cross at `0.746410L`.
- I inspected the combined top-down vorticity and oblique body/Lambda2 sheets
  for the best response-release result and the weaker closure-preview result
  `solver_d5c9dea468e1`. In both, the fish self-propels rather than advects:
  it establishes a coherent alternating posterior wake, follows the same
  compact target-directed arc, and remains stable and planar through the late
  bend. Their visually indistinguishable outer trajectories agree with the
  controller boundary: these variants differ only inside the terminal
  reallocation band.
- Numeric diagnostics resolve the near-tie. The response release improves mean
  distance to `2.42929378L` and final crossing to `0.746410L` relative to the
  plain preview's `2.43063592L` and `0.748252L`, but arrives one `0.0055T`
  integration step later than both the preview and departure-selective
  policies. The departure-selective policy preserves the earlier capture and
  lower inside-`4L` load maxima (about `0.01427/0.00757` force/moment versus
  `0.01548/0.00800` for response release), while missing the response
  release's small distance-integral benefit.
- The evaluated inherited posterior-only release is a concrete negative
  result, not a new candidate: it captures at `25.12402T`, scores
  `-0.53028823`, raises mean/final distance to `2.43085240L/0.748419L`, and
  its two-view sheet shows no compensating new wake topology. Thus splitting
  terminal carrier recovery by joint role breaks the useful coupled traveling
  bend; the next test should keep both joint weights coupled.
- All fast variants already avoid terminal acceleration-cap samples and
  joint-stop dwell. The opportunity is therefore to reconcile the two
  state-feedback benefits—release after the target-relative bend forms and
  rejection of the half-cycle that moves away from that bend—not to add
  curvature, broaden drive relief, or tune the outer carrier.

## Policy hypothesis

Preserve the assigned parent's outer controller, closure preview,
target-geometry redirect, two-joint curvature equilibrium, tracking-error
response trigger, and coupled joint allocation. Compute the positive
derivative of squared target-curvature error,
`max((q-q_target)*q_dot, 0)`, normalized by the declared oscillator scale.
During only the partial carrier-to-curvature entry blend, use that observed
departure phase to increase reallocation as in the evaluated
departure-selective policy; after the bend settles, retain the assigned
parent's evaluated coupled response release. Multiplication by
`gate*(1-gate)` makes phase selection exactly inactive before terminal entry
and after full proximity allocation. This uses observed joint phase without a
clock, vortex phase, route, or world-frame quantity.

Expected evidence is exact outer-command equivalence, the same coherent wake,
the departure policy's earlier/lower-load entry, and the response parent's
mean-distance benefit after settling. Reject the combination if it captures
later than the response parent, loses the mean-distance advantage over plain
preview, changes any command when the proximity gate is zero or one, recreates
joint clipping/stop dwell, or produces a force/moment increase. The new CFD
result is not available to this worker and is intentionally not claimed.

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and asymmetric flapping for turning
source_mechanism: use observed oscillator state to preserve the useful half-cycle and suppress only rhythmic motion opposed to the requested bend
transferable_invariant: when target curvature and propulsion share coupled joints, observed error-growing phase should strengthen curvature allocation during entry, while measured settling can release the coupled rhythm after the response forms
nontransferable_details: published gains, dimensional cadence, duty ratios, species-specific body envelopes, exact tail-beat or vortex phases, full-body waveforms, and prescribed routes
policy_translation: retain normalized body-frame geometry and closure gates; during only the partial entry blend, use bounded positive two-joint curvature-error growth from `phi` and `phi_dot` to advance allocation, then retain coupled tracking-error response release after settling
falsification: reject if pre-terminal commands change, capture or mean distance regresses, the alternating wake loses coherence, or terminal saturation and force/moment peaks increase

## Non-CFD screening of the final architecture

The first drafted composition applied the departure complement only to the
settled response release. A fixed-state replay on the assigned parent's
history showed why that structure was effectively redundant: tracking error
already removes release as departure grows, so the added gate suppressed at
most `0.002139` of allocation and changed an inside-`4L` command by at most
`0.00860 rad/T^2`. It was discarded before CFD rather than spending an
evaluation on another near-inactive gate.

The final architecture stages the two already evaluated response mechanisms
in the regimes where their sampled effects occurred: departure-selective
reallocation acts only during the partial entry blend, and settled response
release remains active afterward. A final synthetic/fixed-state audit must
show exact parent equivalence with proximity gate zero or one, a material
bounded difference during departing partial blend, finite capped commands,
and a complete parameter schema. Those are activation checks only, not a
claim about the pending coupled-flow outcome.

That final audit passes. Proximity-gate endpoints are exactly parent-equivalent;
on the sampled response-parent state history, 401 partial-blend states change,
the phase rule advances the gate by at most `0.15719`, and the maximum command
difference is `2.99996 rad/T^2`. Synthetic departing states return two finite
commands within the declared acceleration limit. The contract checker and
parameter-schema guard pass independently. No CFD was run.
