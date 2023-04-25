# -*- coding: utf-8 -*-

import os
import sys
import cloud_sptheme as csp

sys.path.insert(0, os.path.abspath('.'))

# -- Project information -----------------------------------------------------

project = 'Gil Modules'
copyright = '2023, Erchegyi David'
author = 'Erchegyi David'

version = '0.0.1'
release = '0.0.1'

# -- General configuration ---------------------------------------------------

extensions = [
    'sphinx.ext.githubpages',
]
templates_path = ['_templates']
source_suffix = '.rst'
master_doc = 'index'
language = 'en'
exclude_patterns = ['_build', 'Thumbs.db', '.DS_Store']
pygments_style = None

# -- Options for HTML output -------------------------------------------------
html_theme = 'cloud'
html_theme_path = [csp.get_theme_dir()]
html_theme_options = { "roottarget": "index" }
html_static_path = ['_static']
