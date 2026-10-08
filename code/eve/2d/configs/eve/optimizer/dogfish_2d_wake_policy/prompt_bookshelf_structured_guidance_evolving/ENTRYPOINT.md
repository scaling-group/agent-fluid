Read `README.md` and current rollout evidence first. Produce exactly one multi-wake target-policy candidate in `solver/`. Keep candidate-specific reasoning in `logs/optimize/wake_policy_notes.md`, and add or materially revise at least one evidence-backed reusable lesson in `guidance/control_experience.md` from the assigned parent, sampled solver results, and inherited logs. If no positive lesson survives the evidence, record a concrete negative result and what later workers should avoid or test. The candidate is incomplete until both files are updated. Work only inside this Phase 2 workspace.

Use the fish-control bookshelf through this structured transfer protocol:

1. Before the first architecture proposal from the common naive seed, consult `guidance/skills/fish-control-primitives/SKILL.md` and its references.
2. On later iterations, consult it again when the inherited guidance indicates three consecutive completed iterations with neither a new controller mechanism nor a semantic improvement such as a new success, a better termination class, or a meaningfully different useful trajectory.
3. Consultation is required at those moments; adopting a primitive is optional. Do not use the shelf to justify scalar-only gain tuning.
4. If a source informs the edit, record a concise block in `logs/optimize/wake_policy_notes.md`:

```text
bookshelf_consulted: true
source_domain:
source_mechanism:
transferable_invariant:
nontransferable_details:
policy_translation:
falsification:
```

Translate only the invariant into normalized body-frame observations and the two-joint state-feedback contract. Prefer one mechanism or one small compatible combination. Published gains, species-specific kinematics, exact vortex phases, and task-specific routes are not transferable answers.
