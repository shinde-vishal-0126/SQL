import shutil
import os

source_dir = r"C:\Users\itsys\.gemini\antigravity-ide\brain\530acba5-079e-4a1c-9dab-969448c2b966\.user_uploaded"
dest_dir = r"d:\IMP\SQL\mysql\mysql_basic"
md_file = os.path.join(dest_dir, "SQL_Master_Guide.md")

# 1. Copy all images
print("Copying images to your folder...")
for f in os.listdir(source_dir):
    if f.endswith('.png'):
        src = os.path.join(source_dir, f)
        dst = os.path.join(dest_dir, f)
        shutil.copy2(src, dst)
        print(f"Copied {f}")

# 2. Fix markdown links (Absolute -> Relative)
print("\nFixing image links in SQL_Master_Guide.md...")
with open(md_file, 'r', encoding='utf-8') as file:
    content = file.read()

old_path = "file:///C:/Users/itsys/.gemini/antigravity-ide/brain/530acba5-079e-4a1c-9dab-969448c2b966/.user_uploaded/"
new_path = "./"

if old_path in content:
    content = content.replace(old_path, new_path)
    with open(md_file, 'w', encoding='utf-8') as file:
        file.write(content)
    print("Links fixed successfully!")
else:
    print("Links are already fixed.")

print("\nDone! Please check your Markdown preview now.")
