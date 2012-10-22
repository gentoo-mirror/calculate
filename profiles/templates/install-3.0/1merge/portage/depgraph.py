# Calculate path=/usr/lib/portage/pym/_emerge format=patch
<reg>(self._dynamic_config._scheduler_graph = scheduler_graph
\s+raise self._unknown_internal_error\(\)
\s*
)(\s+)(return retlist, scheduler_graph
\s*
\s+def _show_circular_deps\(self, mygraph\):)</reg>
<text>\1\2# pull calculate package at tail
\2retlist = sorted(retlist,
\2\tkey=lambda x:(1 if u"calculate" in x.cp else 0,
\2\tretlist.index(x)))
\2\3</text>
