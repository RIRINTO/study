import tensorflow as tf 
print(tf.config.list_physical_devices('GPU'))
print(tf.config.list_physical_devices())

print(tf.test.is_gpu_available())
print(tf.test.gpu_device_name())

