miq.light_theme      = "light-theme"
miq.dark_theme       = "dark-theme"
miq.storage_key     = "miq-theme"
miq.button_selector = "[data-toggle-theme]"
miq.html_doc        = miq.select("html")
miq.theme_button    = miq.select(miq.button_selector)

miq.set_theme = (was, now) ->
  miq.html_doc.classList.add(now)
  miq.html_doc.classList.remove(was)
  localStorage.setItem(miq.storage_key, JSON.stringify(now))

miq.handle_button_click = ->
  # get the current theme from localStorage
  current_theme = localStorage.getItem(miq.storage_key)

  # If the current theme and its light theme then set it to dark theme else if
  # its dark then set it to light
  if current_theme
    if (JSON.parse(current_theme) == miq.light_theme)
      miq.set_theme(miq.light_theme, miq.dark_theme)
    else
      miq.set_theme(miq.dark_theme, miq.light_theme)

  else
    # if localStorage is not defined then we want to use whatever the media
    # color-scheme is to switch it to the opposite
    if (window.matchMedia && window.matchMedia("(prefers-color-scheme: dark)").matches)
      miq.set_theme(miq.dark_theme, miq.light_theme)
    else
      miq.set_theme(miq.light_theme, miq.dark_theme)

miq.theme_button.addEventListener("click", miq.handle_button_click)
