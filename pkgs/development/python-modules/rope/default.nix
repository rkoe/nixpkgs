{ stdenv, buildPythonPackage, fetchPypi, pythonAtLeast, nose }:

buildPythonPackage rec {
  pname = "rope";
  version = "0.16.0";

  disabled = pythonAtLeast "3.8";  # 0.17 should support Python 3.8

  src = fetchPypi {
    inherit pname version;
    sha256 = "1zlxdrs6ww2hm41izz67h67z9dkm0rlgw8m04vygaip0q91030yj";
  };

  checkInputs = [ nose ];
  checkPhase = ''
    # tracked upstream here https://github.com/python-rope/rope/issues/247
    NOSE_IGNORE_FILES=type_hinting_test.py nosetests ropetest
  '';

  meta = with stdenv.lib; {
    description = "Python refactoring library";
    homepage = "https://github.com/python-rope/rope";
    maintainers = with maintainers; [ goibhniu ];
    license = licenses.gpl2;
  };
}
