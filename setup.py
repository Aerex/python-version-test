from setuptools import setup

setup(name='ibm-cloud-env',
      version='0.0.6',
      description='Abstraction layer for CF and Kube env variables',
      classifiers=[
            "Programming Language :: Python :: 2.6",
            "Programming Language :: Python :: 2.7",
            "Programming Language :: Python :: 3.3",
            "Programming Language :: Python :: 3.4",
            "Programming Language :: Python :: 3.5",
            "Programming Language :: Python :: 3.6"
      ],
      license='Apache-2.0',
      keywords = ['ibm', 'cloud', 'cloud foundry', 'environment variable', 'kubernetes'],
      url='http://github.ibm.com/Liz-Furlan/ibm_cloud_env',
      author=['Liz Furlan' 'Nana Amfo', 'Joy Chang'],
      author_email=['noamfo@us.ibm.com', 'nanaus13@gmail.com', 'joychang@us.ibm.com'],
      packages=['ibm-cloud-env'],
      install_requires=[
      	'jsonpath_rw'
      ],
      test_suite='nose.collector',
      tests_require=['nose', 'mock'],
      include_package_data=True,
      zip_safe=False)
