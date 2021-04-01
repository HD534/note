## Windows
### download & install
- package python
  >https://www.python.org/downloads/release/python-392/

- add python to Path
- install pip download `get-pip.py` from 
    > https://bootstrap.pypa.io/get-pip.py
https://roytuts.com/installing-pip-with-embeddable-zip-python-in-windows/`
  - config proxy  
  >https://stackoverflow.com/questions/58335414/installing-pip-windows-10-connection-broken
  - ssl verify failed 
  >https://stackoverflow.com/questions/25981703/pip-install-fails-with-connection-error-ssl-certificate-verify-failed-certi

- add pip to Path
  > https://stackoverflow.com/questions/32639074/why-am-i-getting-importerror-no-module-named-pip-right-after-installing-pip
   
- add below to `python_xxx_pth` 
  ```
  Lib\site-packages
  ```



### pip
- `python -m pip install xxx`