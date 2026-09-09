# Multi-wake candidate diagnosis and hypothesis

## Visual diagnosis

- The shared prewarm sheet shows the common release condition: the fish is
  above and downstream of the four-cylinder streets, while the target lies in
  the developed, interacting wake behind the second row. The released policy
  must therefore supply both upstream propulsion and a controlled diagonal
  turn before wake interaction can help; the prewarm is not candidate-specific.
- `solver_3c1578b8a76f` is the strongest finite-progress sample. Its keyframes
  show a visible propulsive body wave and predominantly upstream travel through
  the first four frames, with little net lateral drift. This agrees with head
  displacement `(-3.59, +0.15)L`, minimum range `9.01L`, and progress `0.259`.
  The last frame instead shows the fish tightly folded during an abrupt turn,
  immediately preceding `unstable_dynamics` at `33.06` released time. Both
  acceleration commands reached `31.416 rad/time^2`; RMS lateral force and
  moment rose to `20023.6` and `314391`. Positive body-frame bearing curvature
  plus the angle-only oscillator produced useful self-propulsion, but its
  unsoftened gait and undamped course correction were not viable.
- The assigned parent `solver_f4aa1d08eba0` remains gently curved in the
  keyframes and follows the lower-right advection path without entering the
  useful wake or turning back toward the target. Its mean velocity
  `(0.0523,-0.1117)` nearly equals mean local flow `(0.0540,-0.1123)`, while
  head displacement `(+2.27,-4.79)L`, unchanged `12.42L` minimum range, and
  `-0.122` progress confirm negligible self-propelled target approach. Loads
  are low and action stays below the hard cap, so stability alone is not useful.
  The independent phase-radius sample `solver_83a7583cc3c9` repeats this
  topology (`+2.24L` streamwise displacement, low loads, downstream/lower
  exit). The sampled phase-radius regulation is therefore a concrete negative
  mechanism in this far-field regime, not merely an unlucky scalar score.
- The target-blind seed visibly sustains a body wave and moves `-3.55L`
  upstream, but it is swept `-13.30L` laterally and reaches both acceleration
  caps before leaving the domain. It supports retaining a state-encoded gait,
  not retaining its fast, large, undirected actuation.

## Policy hypothesis

Use the empirically useful positive-bearing steering sign and restore the
angle-only self-excited oscillator, but place it between the passive regulated
rollouts and the unstable progress rollout: a `0.95` period, `15 deg` anterior
amplitude, lower excitation, `10 deg` bounded steering, and measured-yaw
damping. Smoothly limit both joint accelerations to `1000 deg/time^2`, below
the `1800 deg/time^2` hard envelope. The posterior joint retains the sampled
traveling-bend lag and most of the mean steering curvature.

The next evaluation should falsify this candidate unless it (1) visibly
sustains a body wave rather than matching local advection, (2) preserves
negative streamwise displacement and adds target-directed lateral travel,
(3) remains finite past `50.13` released time, and (4) avoids hard acceleration
contact and the force/moment spike of `solver_3c1578b8a76f`. Tight-radius
capture is not claimed from the inherited evidence.
