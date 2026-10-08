# Phase-2 candidate diagnosis and hypothesis

## Available prior evidence

- The only sampled solver, `solver_24bf67867ea8`, is byte-identical to the
  clean-B transferred seed and to the candidate prefill. No inherited
  `logs/optimize/` evidence or separate successful finite comparator is present
  in this workspace, so causal claims below are deliberately limited to this
  one rollout.
- The rollout uses the required direct uniform still-water initialization
  (`U_infinity=[0,0,0]`), is numerically finite, and terminates `left_domain` at
  27.49 T. It reduces head-target distance from 12.33 L to 4.78 L at 17.85 T,
  then departs to 9.71 L and exits through the lower boundary.
- Both visual rows show useful self-propulsion: the top-down sheet develops a
  coherent alternating wake and the oblique Lambda2 sheet shows a persistent
  three-dimensional vortex train. The defect is course control, not failure to
  form a propulsive wake. From roughly 16 T onward the target lies strongly on
  the positive body-lateral side while the fish continues south; the trace has
  about 0.80 L/T southward velocity at termination.
- Reconstructed target geometry shows that the inherited guidance asks for a
  large negative yaw request (about -5 to -6 in its internal units) during the
  missed approach, while the cycle-scale mean heading fails to turn toward the
  target and often drifts in the opposite direction. This identifies a 3D
  steering-polarity/response mismatch rather than insufficient target sensing.
- Against the configured 31.416 rad/T^2 acceleration limit, raw policy output
  exceeds the limit on joint 1 for 70.5% of steps, joint 2 for 77.5%, and at
  least one joint for 97.9%. Thus hard clipping can erase the incremental
  authority of the inherited curvature and half-cycle terms.

## One candidate hypothesis

Preserve the evidenced state-feedback traveling wave, but separate desired yaw
from bend actuation. Convert desired yaw to bend with the response polarity
inferred from this 3D rollout, use one symmetric bounded mean-curvature command,
and allocate acceleration so curvature retains authority over the oscillatory
drive. Gate drive relief by both normalized target misalignment and yaw-rate
response error: a large error with wrong response invokes a redirect, whereas
an observed response in the requested direction releases continuously back to
the propulsive gait. This is one response-gated curvature-redirect mechanism,
not a route or timed maneuver.

Falsification: reject the hypothesis if the next rollout loses the coherent
propulsive wake, still drives south while the target remains positive-lateral,
keeps the same left-domain topology without improving the 4.78 L minimum, or
merely replaces episode clipping with persistent policy-bound commands.

bookshelf_consulted: true
source_domain: biological C-start redirects plus robotic-fish mean-curvature and asymmetric-flapping steering
source_mechanism: large observed direction error invokes bounded curvature and temporarily prioritizes redirect authority; a measured heading response releases back into the posterior traveling beat
transferable_invariant: separate target-referenced mean turning from the propulsive rhythm and schedule their authority from observed error and response
nontransferable_details: species-specific C-start shapes, published gains and frequencies, exact tail-beat phases, full-body kinematics, and prescribed routes
policy_translation: form desired yaw from normalized body-frame target geometry and recent yaw rate, map it explicitly into the two-joint bend polarity evidenced in 3D, retain the joint-state oscillator, and reserve bounded acceleration for symmetric curvature only while geometry and response-error gates agree
falsification: no improved target-side turn or closest approach, loss of the coherent wake, load instability, or persistent policy saturation invalidates the transfer

## Worker-side verification boundary

- The deterministic schema audit found 53 returned parameter fields, 51 direct
  parameter references, and no missing field. The boundary checker passed.
- Static replay of the candidate law on all 4,999 sampled parent states produced
  finite commands with zero physical-limit violations; the largest output was
  31.405 rad/T^2 against the 31.416 rad/T^2 limit. The redirect gate left at
  least 42% drive authority. This checks algebra and bounded allocation only;
  it is not a fluid-dynamic counterfactual.
- The required semantic guidance check passed. The exact Julia contract command
  could not execute because this worker environment has no `julia` binary, so
  syntax/load assertions remain for downstream evaluation infrastructure. No
  formal CFD was run.
