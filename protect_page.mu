#!/usr/bin/env python3
"""
FULLY PROTECTED MICRON TEMPLATE

- Identity-based `.allowed` guard
- Unauthorized users see only a message; no other output is executed
- Authorized users can:
    1. Type simple static text
    2. Paste full Python/Micron pages (like meshchat.mu)
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
else:
    # ---------------------------
    # 4. PROTECTED CONTENT BELOW
    # Everything below this line executes ONLY for allowed identities
    # ---------------------------

    # ---------------------------
    # Option 1: Simple static text output
    # ---------------------------
    # Uncomment or add lines like these:
    # out("# Authorized access")
    # out("You are authorized to view this page.")

    # ---------------------------
    # Option 2: Full Python/Micron page
    # ---------------------------
    # Paste any raw page here, for example meshchat.mu
    # Example:
    # def recover_input(name):
    #     ...
    # tpl = TEMPLATE_MAIN
    # tpl = tpl.replace("{self}", FILE)
    # tpl = tpl.replace("{date_time}", time.strftime("%Y-%m-%d %H:%M:%S"))
    # tpl = tpl.replace("{entrys}", subprocess.getoutput("/home/bamse/.local/bin/rnstatus").strip())
    # print(tpl)
