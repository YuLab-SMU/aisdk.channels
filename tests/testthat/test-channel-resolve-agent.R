# channel_resolve_agent is internal to aisdk.channels; tested here (in its own
# package) so no cross-package ::: is needed. Agent and the skill runtime come
# from aisdk core (attached via tests/testthat.R).

test_that("channel_resolve_agent auto-creates a skill-aware agent", {
  temp_root <- tempdir()
  skill_dir <- file.path(temp_root, "channel_skill_test")
  dir.create(skill_dir, recursive = TRUE, showWarnings = FALSE)

  dummy_skill_path <- file.path(skill_dir, "pdf_helper")
  dir.create(dummy_skill_path, recursive = TRUE)
  writeLines(c(
    "---",
    "name: pdf_helper",
    "description: Handles PDF and OCR tasks",
    "---",
    "Instructions"
  ), file.path(dummy_skill_path, "SKILL.md"))

  agent <- channel_resolve_agent(
    agent = NULL,
    skills = skill_dir,
    model = "mock:test"
  )

  expect_s3_class(agent, "Agent")
  expect_true(grepl("Users should not need to know what skills exist", agent$system_prompt, fixed = TRUE))
  expect_true(grepl("pdf_helper", agent$system_prompt, fixed = TRUE))

  tool_names <- sapply(agent$tools, function(t) t$name)
  expect_true("load_skill" %in% tool_names)
  expect_true("execute_skill_script" %in% tool_names)
  expect_true("reload_skills" %in% tool_names)
})
