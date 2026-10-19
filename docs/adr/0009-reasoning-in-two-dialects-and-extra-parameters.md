# Reasoning in two fixed dialects; what a model needs beyond them goes in the Profile's Extra parameters

Providers do not agree on how to ask a model to reason, and on the same Provider each model family can want something different. On TensorX on 2026-10-19: Qwen 3.8 takes `reasoning_effort` but answers 400 to `none` and `high` (it wants `xhigh`); GLM 5.3 takes `none`/`low`/`high`; GLM 5.1, DeepSeek V4 and MiniMax M3 want their own key under `chat_template_kwargs` and silently ignore `reasoning_effort`. The same model can behave differently on another Provider: `qwen3.8-27b` on Regolo accepted `none`. OpenRouter is the exception, because it takes one `reasoning` object and translates it for each model itself.

Takku therefore knows two dialects and no model names. The Reasoning menu of a Profile (model default, off, low, medium, high) is sent as `reasoning.effort` to OpenRouter, recognised by its host, and as OpenAI's `reasoning_effort` to every other Provider. Whatever a model needs beyond that goes in the Profile's **Extra parameters**: a JSON object written by the user and added to every request of the Profile (Summary, its blocks and merge, title, *Test connection*). Any key is allowed except `model` and `messages`. Each top-level key replaces what Takku would send for it, menu included, with no deep merge. The editor refuses to save anything that is not a JSON object or that sets those two keys. Only the request body is covered, no HTTP headers.

## Considered Options

- **A table of models inside Takku**, mapping each model to its key and levels: rejected, since new models come out every week and the table could not be kept up to date by one person.
- **The menu alone**: DeepSeek on TensorX could never reason, and Qwen 3.8 could never reach its default `xhigh`.
- **Extra parameters alone**: one mechanism, but JSON to write even on OpenRouter, where the menu is all that is needed.
- **Retrying without reasoning when the Provider refuses it**: rejected. Reasoning and Extra parameters are typed by hand, so a mistake in them must show, not be hidden behind a second request.

## Consequences

- When the Provider refuses a request (400 or 422; not 401, 404 or 429, which say nothing about what was sent) from a Profile that sets reasoning or Extra parameters, the error adds what the Profile sent beyond a plain request (the reasoning level, unless the Extra parameters replaced it, and whether there were Extra parameters), without its name or the parameters' content: the message also goes to the log, which *Report a problem…* includes. *Test connection* sends a short request with the same reasoning and Extra parameters as a Summary, so a value the model refuses shows when the Profile is set up.
- The menu keeps the four levels OpenAI, OpenRouter and Regolo share; `xhigh`, `max` and the like are Extra parameters.
- The reply is still read in every form seen so far (`reasoning_content` ignored, Mistral's chunk list, reasoning before `</think>` or `</thinking>`): there is nothing to configure there per model, and getting it wrong would put the reasoning in the note.
