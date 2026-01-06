#!/usr/bin/env python3

"""
PROTECTED MICRON TEMPLATE

- Place this at the top of any Micron/Python page
- Creates an identity-based `.allowed` guard
- Everything below the `# --- PROTECTED CONTENT BELOW ---` line
  executes only if the connecting client is allowed
- Unauthorized visitors see a message and the page stops executing
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
# 2. Get remote identity
# ---------------------------
remote_identity = os.getenv("remote_identity", "").strip().lower()

# ---------------------------
# 3. Authorization check
# ---------------------------
if not remote_identity or remote_identity not in allowed_idents:
    out("# Unauthorized access")
    out("""
# Unauthorized

You are not authorized to view this page.
""")
    # Stop execution — do NOT use sys.exit()
    # The rest of the page is ignored for unauthorized users
else:
    pass  # Authorized users continue executing below

# ---------------------------
# 4. PROTECTED CONTENT BELOW
# ---------------------------
# Everything below this line executes only for allowed identities
# You can:
#   - Paste a full Python/Micron page (e.g., meshchat.mu)
#   - Or write simple static Micron output using out()
# Example static text:
# out("# Authorized access")
# out("You are authorized to view this page.")
#
# Example full page:
# def recover_input(name):
#     ...
# paste any existing page code here


out("# Authorized access")
out("You are authorized to view this page.")
