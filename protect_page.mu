#!/usr/bin/env python3
"""
NomadNet Protected Micron Page Guard

- Uses `.allowed` file to control access
- Grabs the connecting client identity exactly as `meshchat.mu` does
- Stops execution for unauthorized users
- Protected section below remains exactly as-is
"""

import sys
import os
from pathlib import Path

def out(line=""):
    """Print a line to the page"""
    sys.stdout.write(line + "\n")
    sys.stdout.flush()

# ---------------------------
# 1. Load allowed identities
# ---------------------------
page_dir = Path(os.path.dirname(__file__))
allowed_file = page_dir / ".allowed"
allowed_idents = set()

if allowed_file.exists():
    allowed_idents = set(
        line.strip().lower()
        for line in allowed_file.read_text().splitlines()
        if line.strip()
    )

# ---------------------------
# 2. Get runtime identity (as meshchat.mu)
# ---------------------------
try:
    remote_identity = os.environ["remote_identity"].strip().lower()
except KeyError:
    remote_identity = None

# ---------------------------
# 3. Authorization check
# ---------------------------
if not remote_identity or remote_identity not in allowed_idents:
    out("# Unauthorized access")
    out("""
# Unauthorized

You are not authorized to view this page.
""")
    raise SystemExit  # Stop execution

# ---------------------------
# 4. PROTECTED SECTION BELOW
# Paste your original meshchat.mu or any other page here
# This includes TEMPLATE_MAIN, system calls, comments, etc.
# ---------------------------

out("# Authorized access")
out("You are authorized to view this page.")

