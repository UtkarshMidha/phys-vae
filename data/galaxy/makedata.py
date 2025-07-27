from PIL import Image
import h5py
import numpy as np

with h5py.File('./Galaxy10.h5', 'r') as F:
    all_images = np.array(F['images'])     # shape: (N, 256, 256, 3)
    all_labels = np.array(F['ans'])        # shape: (N,)

# Filter class 6
mask = all_labels.astype(np.float32) == 6.0
filtered_images = all_images[mask]

# Resize to (69, 69)
resized_images = []
for img in filtered_images:
    img_pil = Image.fromarray(img)
    img_resized = img_pil.resize((69, 69))
    resized_images.append(np.array(img_resized))

images = np.stack(resized_images).astype(np.float32) / 255.0  # shape: (N, 69, 69, 3)

# Transpose to (N, 3, 69, 69)
data = np.transpose(images, (0, 3, 1, 2))

# Save
np.save('./data_all.npy', data)
print('saved data: mean(x)={:.3e}'.format(np.mean(data)))
print('saved shape:', data.shape)

