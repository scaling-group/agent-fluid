# Candidate diagnosis and hypothesis

## Evidence read before editing

- All four sampled evaluations are finite, direct-uniform still-water releases
  with `U_infinity=[0,0,0]`, no cylinders, and no prewarm. Their translation is
  self-propelled; all terminate `left_domain`, so none supports a success claim.
- Both rows of every combined keyframe sheet were inspected. The
  `solver_5c5f9d80447b` and `solver_95d1e880b3e5` failures lay down coherent
  alternating mid-plane streets and compact oblique Lambda2 structures but
  follow upper/left routes and remain outside `3.00L`. The carrier is useful;
  their longer scalar survival is not useful target acquisition.
- The assigned-parent half-cycle attenuation (`solver_a8af0d71b0de`) provides
  the strongest sampled path, reaching `1.2669L` at `18.6945T` with inertial
  speed `0.7766L/T`. Its closest row has only about `5.50/7.16 rad/T^2` of
  action, and both visual rows then show little new wake while the joints and
  commands collapse. It coasts below the target into the lower exit. The
  inherited energy-reserve variant did not rescue the topology: its completed
  score log remains `left_domain` and worsens closest approach to `1.7708L`.
- The newly sampled terminal mean-curvature replacement
  (`solver_213717a6b100`) keeps an alternating wake through the turn, but
  worsens closest approach to `1.5454L`. At its closest row both actions are at
  the `31.416 rad/T^2` envelope. Preserving the rhythm is therefore necessary
  but not sufficient when the edit also withdraws the direct shared steering
  that produced the useful approach.
- The inherited unmodified achieved-course servo reached about `1.044L`, while
  cadence relief, carrier attenuation, energy-guarded attenuation, and
  mean-curvature replacement all retained the below-target `left_domain`
  class. The next test must preserve its far route signal and full carrier,
  while changing only how terminal steering uses beat phase.

## One candidate mechanism

Keep the normalized body-frame target-versus-achieved-course servo, cadence,
and posterior-lag traveling bend unchanged. Inside the evidenced `4L` terminal
region, smoothly move the existing shared steering impulse onto the observed
half-cycle whose carrier acceleration has the same sign as the requested bend.
The complementary half-cycle receives no steering but retains its complete
carrier acceleration. A factor-two aligned pulse preserves approximately the
cycle-mean steering budget without suppressing either carrier half-cycle; the
physical output clamp remains the final owned envelope.

Expected signature: behavior outside `4L` is identical to the inherited direct
course servo; terminal joint excursion and alternating wake remain active;
phase-selective steering redirects the below-target path through the `0.75L`
capture disk instead of producing either the parent's coast or the
mean-curvature sample's saturated wider miss.

Falsification: reject if far-field behavior changes, joint excursion or new
wake production collapses, acceleration/speed saturation grows, closest
approach fails to beat `1.2669L`, or the same below-target `left_domain`
topology remains. If the carrier survives but the route still misses, later
work should test a terminal yaw/slip response signal rather than more cadence,
route gain, carrier attenuation, or static mean curvature.

bookshelf_consulted: true
source_domain: robotic-fish asymmetric flapping and duty-ratio turning
source_mechanism: obtain bounded mean turning by concentrating steering authority on the favorable beat half-cycle while retaining a propulsive rhythm
transferable_invariant: preserve the traveling carrier and use observed beat phase to redistribute rather than increase the cycle-mean steering impulse
nontransferable_details: published gains, prescribed clock phase, robot or species kinematics, dimensional cadence, exact vortex phases, and task-specific routes
policy_translation: use normalized body-frame course error for turn direction and each joint's carrier acceleration as phase; inside the approach gate pulse the owned steering only when its sign aligns with the carrier, without scaling the carrier itself
falsification: reject if far-field closure changes, the carrier or wake weakens, saturation grows, closest approach does not beat 1.2669L, or the below-target left_domain class survives

## Non-CFD verification

- The material-guidance check and solver editable-boundary check pass. The
  deterministic static schema audit finds no `params.FIELD` reference missing
  from `target_policy_params()`, and the requested 3D shape-policy candidate
  remains present and nonempty.
- The mandated Julia smoke command could not execute because this workspace
  image has no `julia` executable on `PATH`; Python Julia bridges and local
  project runtimes are also absent. This is an environment limitation, not a
  passing runtime claim. No CFD was run.
