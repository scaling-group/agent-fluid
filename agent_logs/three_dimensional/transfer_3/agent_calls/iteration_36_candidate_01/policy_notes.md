# Evidence-backed joint-rate anti-windup candidate

## Visual and metric diagnosis recorded before the policy edit

- All four sampled solver rollouts satisfy the frozen experiment contract:
  direct-uniform `U_infinity=(0,0,0)` initialization, no prewarm or cylinders,
  finite dynamics, and capture at `18.6560--18.7330T`. I inspected the
  combined sheets for the best-score exact route and the joint-rate
  anti-windup variant, plus the assigned parent's terminal-envelope rollout,
  from release through termination. In each top-down row the fish translates
  under its own body motion and forms a coherent alternating caudal-vorticity
  street by `4T`; in each oblique row compact Lambda2 structures form behind
  the moving tail. Local-flow RMS is only `0.01804--0.01822U`, agreeing that
  the motion is self-propelled rather than passive advection. None shows wake
  breakup, wasteful growing lateral excursion, collision, boundary contact,
  or numerical instability.
- The exact prefilled policy has two current same-hash captures at `18.6725T`
  and `18.7330T`, mean distance `2.02018L` and `2.01959L`, posterior action
  RMS `28.77` and `28.72 rad/T^2`, posterior acceleration-limit occupancy
  `75.46%` and `75.22%`, and force/moment RMS
  `0.01331--0.01335 / 0.00693--0.00695`. Their small score and timing spread
  is the appropriate baseline; it does not justify another scalar or
  instantaneous fluid-response adjustment.
- The sampled joint-rate anti-windup policy captures at `18.7000T` with mean
  distance `2.02103L`, inside the exact-route timing and distance envelope.
  Its top-down and oblique wakes and `0.536U` speed at `4T` are visually and
  metrically indistinguishable from the productive baseline, while posterior
  action RMS falls to `28.24 rad/T^2` and posterior acceleration-limit
  occupancy to `73.97%`. It returns zero on `6.38%` of samples where the
  posterior joint is at the speed boundary, replacing infeasible outward
  work while retaining reverse braking. Force/moment RMS
  `0.01333/0.00694` still overlaps baseline, and rate-limit residence is not
  reduced, so this is evidence for feasible-command cleanup without a route
  penalty, not evidence for lower hydrodynamic load or faster capture.
- The assigned parent's closing-speed-gated carrier contraction is the
  informative negative. Its wake remains coherent, but capture slows to
  `18.8705T`, mean distance rises to `2.04281L`, and score falls to
  `-0.15464`. Although posterior occupancy and force/moment RMS fall to
  `74.06%` and `0.01312/0.00683`, anterior occupancy rises to `42.32%` and
  range remains `2.8599L` at `16T` and `1.3862L` at `18T`. That mechanism
  traded terminal progress for lower load and shifted effort upstream; it
  should be removed rather than retuned or combined with anti-windup.

## Policy hypothesis recorded before the policy edit

Produce exactly one candidate by applying the already sampled one-sided
joint-rate anti-windup projection to the prefilled actuator-consistent route.
Keep the normalized bearing-plus-LOS-rate C-bend, traveling two-joint carrier,
persistent same-side posterior phase recruitment, phase rotation, and
componentwise acceleration projection unchanged. At the parameter-owned
`260 deg/T` joint-speed boundary, return zero only for acceleration whose
product with the observed joint velocity is positive; retain the complete
opposite-sign command for braking. Preserve the existing posterior persistence
gate by using continuing raw outward demand as its feasible-action witness
only while the returned action is zero at that boundary.

Support in a later evaluation requires capture within the replicated
`18.6725--19.0520T` route band, mean distance no greater than `2.02129L`, and
coherent self-propelled wakes in both views. The anti-windup claim additionally
requires posterior action RMS or acceleration-limit occupancy below the exact
sample's `28.72 rad/T^2` / `75.22%` lower bounds without force/moment RMS above
`0.01350/0.00703`. Falsify it on delayed/lost capture, weakened propulsion,
impaired braking or phase reversal, load growth, or no replicated effort
separation; in that case restore the plain feasible-action projection rather
than tuning the speed threshold. The current candidate's CFD runs only after
this worker exits and is not used as evidence here.

## Structured bookshelf transfer

bookshelf_consulted: true
source_domain: sensor-modulated robotic-fish CPG control and actuator-envelope gait design
source_mechanism: preserve a coordinated rhythmic carrier while joint-state feedback prevents commands from winding farther into an active actuator constraint
transferable_invariant: keep the directed posterior-lagged traveling bend primary; at a hard joint-speed boundary suppress only same-direction acceleration and preserve reverse braking authority
nontransferable_details: published gains, dimensional frequencies, species or robot kinematics, full-body waveforms, exact vortex phases, actuator hardware, and task-specific routes
policy_translation: retain the normalized body-frame LOS route and two-joint phase actuator, then project each feasible acceleration using observed joint velocity and a parameter-owned speed limit under a reflection-equivariant signed-product test
falsification: reject if capture leaves the replicated route band, either wake weakens, braking or phase reversal is impaired, force/moment loads exceed the baseline envelope, or posterior effort no longer separates from the plain route
