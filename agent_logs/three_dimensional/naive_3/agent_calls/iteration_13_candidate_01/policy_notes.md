# Wake-policy candidate notes

## Evidence diagnosis before the policy edit

- The assigned parent and all four sampled evaluations report direct uniform
  still-water initialization with `U_infinity=(0,0,0)`, no cylinders, and no
  prewarm snapshot. Their roughly `31T` travel is therefore self-propulsion,
  not advection or inherited-flow contamination.
- I compared the combined sheets for the best sampled approach
  (`solver_563a0d75514e`, `2.385L`) and the response-gated regression
  (`solver_fe524b5f52e2`, `2.536L`) from release through termination. In both
  top-down rows, a long alternating vorticity street follows the fish as it
  approaches diagonally, passes below the target, and turns into a nearly
  vertical downward path. Both oblique rows retain compact alternating
  Lambda2 structures through the turn. Neither case is unstable, passively
  advected, colliding, or wake-starved; both remain powered to the lower
  virtual boundary.
- The metrics agree with the visual diagnosis. All four samples terminate
  `left_domain` at `30.866--31.581T`, with nearly identical mean distance
  (`8.436--8.448L`) and final distance (`9.188--9.207L`). Full-direction
  steering/gating reaches `2.494L`, a posterior half-cycle counterbend reaches
  `2.512L`, and a closure/bearing-response-gated opposite-sign posterior
  equilibrium reaches `2.536L`. Thus those posterior equilibrium and gate
  mechanisms do not produce a semantic improvement.
- The response-selective posterior-wave brake is the only positive local
  signal in this sampled batch: it reaches `2.385L` and the best score
  (`-10.2115`) while preserving mean distance (`8.4358L`). Its unchanged
  lower exit shows that weakening posterior thrust on the wrong-way yaw
  half-cycle is insufficient. The inherited logs likewise show that symmetric
  posterior hold changed the older `2.443L` carrier by only `0.014L`, whereas
  persistent and response-gated posterior counterbends regressed. Further
  posterior gate complexity or scalar carrier tuning is not supported.

## Policy hypothesis

Return to the evidenced alignment-gated, bounded-curvature carrier and change
one actuator allocation. In a smooth near-target envelope, when the full
body-frame target direction is materially lateral and measured heading rate
rotates farther away from it, attenuate the anterior oscillator acceleration
about its steering equilibrium. Preserve the posterior mean curvature,
state-derived phase lag, and alignment-gated traveling wave without a terminal
posterior hold or bias. This relocates response-selective yaw braking from the
thrust-dominant posterior actuator to the anterior steering carrier.

The expected evidence is unchanged far-field displacement and posterior wake
coherence, followed by reduced wrong-way terminal yaw without posterior
coasting. Capture, a better termination class, or a minimum below `2.385L`
without worsening the `8.4358L` mean-distance benchmark supports the actuator
allocation. Falsify it on altered cruise motion, loss of alternating wake
coherence, premature speed loss, a short-radius curl, increased command/load
residence, or the same lower exit without a useful local or integral gain.

```text
bookshelf_consulted: true
source_domain: elongated-body posterior-thrust allocation combined with sensor-modulated robotic-fish CPG turning
source_mechanism: preserve the lagged posterior propulsive wave while applying bounded response-selective damping to the anterior steering oscillator
transferable_invariant: separate propulsion and steering roles so counterproductive measured yaw reduces anterior rhythmic authority without continuously biasing or suppressing the posterior traveling wave
nontransferable_details: published gains, dimensional frequencies, species-specific kinematics, robot duty ratios, exact vortex phases, fixed approach distances, burst durations, and task-specific routes
policy_translation: normalized body-frame full target direction and distance localize a reflection-equivariant gate; bounded heading rate selects wrong-way response, which scales anterior oscillator acceleration about its target-curvature equilibrium while the two-joint posterior lag contract is retained
falsification: reject on changed far-field progress, wake decoherence, early speed loss, tighter curling, greater command or load residence, no improvement beyond 2.385L with comparable mean distance, or persistence of the powered lower exit
```

## Evaluation boundary

The current candidate has no CFD result. Deterministic contract and completed-
trajectory replay checks can establish boundedness, symmetry, signal locality,
and implementation behavior only; EvE performs the coupled CFD evaluation
after this worker exits.

## Implemented candidate and pre-CFD checks

The candidate preserves the bounded mean-curvature request, alignment-gated
posterior lag, posterior steering share, carrier values, and command reserve.
Only the acceleration of the anterior oscillator about its requested
equilibrium is multiplied by the smooth distance/direction/yaw-response gate.
All `21` referenced parameter fields are declared by
`target_policy_params()`.

Replay of completed trajectories is a signal diagnostic, not new CFD
evidence. Across the four samples, mean brake weight is `0.00298--0.00325`
beyond `4L`, `0.090--0.120` between `3--4L`, and `0.253--0.302` inside `3L`.
For three of the four sampled minima, wrong-way yaw gives brake weight
`0.865--0.913` and anterior authority `0.407--0.438`; the posterior half-cycle
counterbend trace has already arrested yaw at its exact minimum, so the gate
naturally releases there (`0.996` authority). This establishes cruise locality
and measured-response selection without predicting coupled hydrodynamics.

The mandated guidance-semantic check, lightweight Julia policy contract, and
solver-boundary check pass. Direct probes pass reflection equivariance,
corrective-yaw release, far/near locality, finiteness, and configured command
bounds. All `324` repository non-CFD assertions pass. Formal CFD remains
deferred to EvE.
