# Wake-policy candidate notes

## Evidence read before the policy edit

- The shared prewarm sheet shows four developed, interacting cylinder streets
  between the held fish and the second-row target. The fish begins above and
  downstream of that mixed-wake region, so successful motion must first redirect
  and then retain leftward propulsion; the common prewarm does not distinguish
  candidates.
- `solver_5133b56d2de2` is the strongest sampled finite rollout. Its released
  sheet shows a sharp initial redirect outside the main wake followed by a
  coherent, self-propelled leftward traverse into the target. The regular body
  wake and mean fish velocity `x=-0.2360` versus mean local flow `x=-0.1454`
  rule out passive advection as the main source of progress. It reaches in
  `46.035`, has mean distance `2.0695L`, and uses RMS force/moment
  `51.40/761.46`.
- `solver_45b5e77accc8` has the same useful redirect-and-traverse topology. Its
  course-slip correction reaches more slowly in `48.032` with mean distance
  `2.1003L`, but lowers RMS force/moment to `37.92/605.38`.
- `solver_25436e69e921` applied the slip-corrected error to both the steering
  residual and bearing-dependent reservation. Although it still reaches, it
  does not combine the parent mechanisms: versus the raw-bearing scheduler it
  is slower (`46.761`), has worse mean distance (`2.1087L`), higher mean command
  energy (`1259.8`), and higher RMS force/moment (`59.04/923.45`). Its maximum
  joint excursions (`0.634/0.586 rad`) also exceed the scheduler's
  (`0.606/0.546 rad`). All sampled successes still touch both speed and
  candidate acceleration limits. No sampled failure keyframe is present in
  this workspace, so no visual claim is made about the inherited unstable
  curvature-equilibrium failure; its logged `16749.8/290421` force/moment
  remains scalar negative evidence against replacing the validated carrier.

## Candidate hypothesis

Preserve the evaluated oscillator, posterior lag, same-sign steering residual,
envelope, and gains. Make one structural correction to the unsuccessful
combination: use slip-corrected body-frame bearing only to form the steering
request, while scheduling reserved steering authority from raw body-frame
bearing. This separates “where to turn” from “how much actuator budget must not
be erased by carrier saturation.” It should retain the scheduler's decisive
large-error redirect while allowing measured targetward lateral course to damp
redundant curvature. The candidate is falsified if it loses target reach, fails
to approach the scheduler's `46.035` arrival/`2.0695L` mean distance, or fails
to improve the scheduler's `51.40/761.46` RMS force/moment without a compensating
route improvement.

bookshelf_consulted: true
source_domain: robotic-fish CPG direction tracking and asymmetric turning
source_mechanism: sensor feedback modulates a rhythmic steering residual while turning authority remains a distinct bounded actuator-allocation role
transferable_invariant: preserve the propulsive rhythm and give geometric direction error and measured course response distinct closed-loop roles
nontransferable_details: published gains, clock phase, duty ratios, robot geometry, species kinematics, exact wake phase, and task-specific routes
policy_translation: subtract bounded normalized body-lateral course from body-frame bearing for the residual, but compute the existing reservation schedule from raw body-frame bearing
falsification: reject if capture is lost or if the decoupled controller retains neither the scheduler's route/arrival advantage nor the slip controller's load advantage
