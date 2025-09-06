require("full-border"):setup()
require("starship"):setup()

-- add gap between tmux and yazi
local old_layout = Root.layout
Root.layout = function(self, ...)
  ---@diagnostic disable-next-line: undefined-field
  self._area = ui.Rect({ x = self._area.x, y = self._area.y, w = self._area.w, h = self._area.h }):pad(ui.Pad.bottom(1))
  return old_layout(self, ...)
end
