from __future__ import absolute_import, division, print_function

import subprocess
from shlex import quote

from ranger.api.commands import Command
from ranger.ext.img_display import ImageDisplayer, register_image_displayer

# You always need to import ranger.api.commands here to get the Command class:


@register_image_displayer("wezterm-image-display-method")
class WeztermImageDisplayer(ImageDisplayer):
    def draw(self, path, start_x, start_y, width, height):
        print("\033[%d;%dH" % (start_y, start_x + 1))
        path = quote(path)
        draw_cmd = "wezterm imgcat {} --width {} --height {}".format(
            path, width, height
        )
        subprocess.run(draw_cmd.split(" "))

    def clear(self, start_x, start_y, width, height):
        cleaner = " " * width
        for i in range(height):
            print("\033[%d;%dH" % (start_y + i, start_x + 1))
            print(cleaner)


class show_in_finder(Command):
    """
    :show_in_finder

    Present selected files in finder
    """

    def execute(self):
        self.fm.run("open .", flags="f")


class mkcd(Command):
    """
    :mkcd <dirname>

    Creates a directory with the name <dirname> and enters it.
    """

    def execute(self):
        import re
        from os import makedirs
        from os.path import expanduser, join, lexists

        dirname = join(self.fm.thisdir.path, expanduser(self.rest(1)))
        if not lexists(dirname):
            makedirs(dirname)

            match = re.search("^/|^~[^/]*/", dirname)
            if match:
                self.fm.cd(match.group(0))
                dirname = dirname[match.end(0) :]

            for m in re.finditer("[^/]+", dirname):
                s = m.group(0)
                if s == ".." or (
                    s.startswith(".") and not self.fm.settings["show_hidden"]
                ):
                    self.fm.cd(s)
                else:
                    ## We force ranger to load content before calling `scout`.
                    self.fm.thisdir.load_content(schedule=False)
                    self.fm.execute_console("scout -ae ^{}$".format(s))
        else:
            self.fm.notify("file/directory exists!", bad=True)
