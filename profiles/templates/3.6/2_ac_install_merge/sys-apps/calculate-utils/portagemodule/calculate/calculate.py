# Copyright 2005-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

import io
import logging
import subprocess

import portage
from portage import os
from portage.util import writemsg_level, shlex_split
from portage.util.futures import asyncio
from portage.output import create_color_func, EOutput
good = create_color_func("GOOD")
bad = create_color_func("BAD")
warn = create_color_func("WARN")
from portage.sync.syncbase import NewBase

class CalculateSync(NewBase):
	'''Calculate sync class'''

	short_desc = "Perform sync operations on calculate based repositories"

	@staticmethod
	def name():
		return "CalculateSync"


	def __init__(self):
		NewBase.__init__(self, "cl-core", "sys-apps/calculate-utils")

	def update(self):
		"""
		Internal function to update an existing calculate repository

		@return: tuple of return code (0=success), whether the cache
			needs to be updated
		@rtype: (int, bool)
		"""

		#calculate update
		exitcode = portage.process.spawn_bash(
                    "/usr/sbin/cl-core --method update --rep %s "
                    "--sync-only on --skip-eix-update -T none" % self.repo.name)
		if exitcode != os.EX_OK:
			msg = "!!! calculate update error; exiting."
			self.logger(self.xterm_titles, msg)
			writemsg_level(msg + "\n", noiselevel=-1, level=logging.ERROR)
		return (exitcode, False)
