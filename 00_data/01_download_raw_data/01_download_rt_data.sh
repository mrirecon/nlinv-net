set -eu
SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

download()
(
	URL=$1
	DST=$2

	if [ ! -f "$DST" ]; then
		TMPFILE=$(mktemp)
   		wget -O $TMPFILE $URL
		mv $TMPFILE $DST
	fi
)

RAWDIR=${RAWDIR:-../10_raw_data}

download https://zenodo.org/record/10492333/files/vol0001_vis1.cfl $RAWDIR/vol0001_vis1.cfl
download https://zenodo.org/record/10492333/files/vol0001_vis1.hdr $RAWDIR/vol0001_vis1.hdr
download https://zenodo.org/record/10492333/files/vol0002_vis1.cfl $RAWDIR/vol0002_vis1.cfl
download https://zenodo.org/record/10492333/files/vol0002_vis1.hdr $RAWDIR/vol0002_vis1.hdr
download https://zenodo.org/record/10492333/files/vol0003_vis1.cfl $RAWDIR/vol0003_vis1.cfl
download https://zenodo.org/record/10492333/files/vol0003_vis1.hdr $RAWDIR/vol0003_vis1.hdr
download https://zenodo.org/record/10492333/files/vol0004_vis1.cfl $RAWDIR/vol0004_vis1.cfl
download https://zenodo.org/record/10492333/files/vol0004_vis1.hdr $RAWDIR/vol0004_vis1.hdr
download https://zenodo.org/record/10492333/files/vol0005_vis1.cfl $RAWDIR/vol0005_vis1.cfl
download https://zenodo.org/record/10492333/files/vol0005_vis1.hdr $RAWDIR/vol0005_vis1.hdr
download https://zenodo.org/record/10492333/files/vol0006_vis1.cfl $RAWDIR/vol0006_vis1.cfl
download https://zenodo.org/record/10492333/files/vol0006_vis1.hdr $RAWDIR/vol0006_vis1.hdr
download https://zenodo.org/record/10492333/files/vol0007_vis1.cfl $RAWDIR/vol0007_vis1.cfl
download https://zenodo.org/record/10492333/files/vol0007_vis1.hdr $RAWDIR/vol0007_vis1.hdr
download https://zenodo.org/record/10492333/files/vol0008_vis1.cfl $RAWDIR/vol0008_vis1.cfl
download https://zenodo.org/record/10492333/files/vol0008_vis1.hdr $RAWDIR/vol0008_vis1.hdr
download https://zenodo.org/record/10492333/files/vol0009_vis1.cfl $RAWDIR/vol0009_vis1.cfl
download https://zenodo.org/record/10492333/files/vol0009_vis1.hdr $RAWDIR/vol0009_vis1.hdr
download https://zenodo.org/record/10492333/files/vol0010_vis1.cfl $RAWDIR/vol0010_vis1.cfl
download https://zenodo.org/record/10492333/files/vol0010_vis1.hdr $RAWDIR/vol0010_vis1.hdr
download https://zenodo.org/record/10492333/files/vol0011_vis1.cfl $RAWDIR/vol0011_vis1.cfl
download https://zenodo.org/record/10492333/files/vol0011_vis1.hdr $RAWDIR/vol0011_vis1.hdr
download https://zenodo.org/record/10492333/files/vol0012_vis1.cfl $RAWDIR/vol0012_vis1.cfl
download https://zenodo.org/record/10492333/files/vol0012_vis1.hdr $RAWDIR/vol0012_vis1.hdr
download https://zenodo.org/record/10492333/files/vol0013_vis1.cfl $RAWDIR/vol0013_vis1.cfl
download https://zenodo.org/record/10492333/files/vol0013_vis1.hdr $RAWDIR/vol0013_vis1.hdr
download https://zenodo.org/record/10492333/files/vol0014_vis1.cfl $RAWDIR/vol0014_vis1.cfl
download https://zenodo.org/record/10492333/files/vol0014_vis1.hdr $RAWDIR/vol0014_vis1.hdr

download https://zenodo.org/record/10492337/files/vol0015_vis1.cfl $RAWDIR/vol0015_vis1.cfl
download https://zenodo.org/record/10492337/files/vol0015_vis1.hdr $RAWDIR/vol0015_vis1.hdr
download https://zenodo.org/record/10492337/files/vol0016_vis1.cfl $RAWDIR/vol0016_vis1.cfl
download https://zenodo.org/record/10492337/files/vol0016_vis1.hdr $RAWDIR/vol0016_vis1.hdr
download https://zenodo.org/record/10492337/files/vol0017_vis1.cfl $RAWDIR/vol0017_vis1.cfl
download https://zenodo.org/record/10492337/files/vol0017_vis1.hdr $RAWDIR/vol0017_vis1.hdr
download https://zenodo.org/record/10492337/files/vol0018_vis1.cfl $RAWDIR/vol0018_vis1.cfl
download https://zenodo.org/record/10492337/files/vol0018_vis1.hdr $RAWDIR/vol0018_vis1.hdr
download https://zenodo.org/record/10492337/files/vol0019_vis1.cfl $RAWDIR/vol0019_vis1.cfl
download https://zenodo.org/record/10492337/files/vol0019_vis1.hdr $RAWDIR/vol0019_vis1.hdr
download https://zenodo.org/record/10492337/files/vol0020_vis1.cfl $RAWDIR/vol0020_vis1.cfl
download https://zenodo.org/record/10492337/files/vol0020_vis1.hdr $RAWDIR/vol0020_vis1.hdr
download https://zenodo.org/record/10492337/files/vol0021_vis1.cfl $RAWDIR/vol0021_vis1.cfl
download https://zenodo.org/record/10492337/files/vol0021_vis1.hdr $RAWDIR/vol0021_vis1.hdr
download https://zenodo.org/record/10492337/files/vol0022_vis1.cfl $RAWDIR/vol0022_vis1.cfl
download https://zenodo.org/record/10492337/files/vol0022_vis1.hdr $RAWDIR/vol0022_vis1.hdr
download https://zenodo.org/record/10492337/files/vol0023_vis1.cfl $RAWDIR/vol0023_vis1.cfl
download https://zenodo.org/record/10492337/files/vol0023_vis1.hdr $RAWDIR/vol0023_vis1.hdr
download https://zenodo.org/record/10492337/files/vol0024_vis1.cfl $RAWDIR/vol0024_vis1.cfl
download https://zenodo.org/record/10492337/files/vol0024_vis1.hdr $RAWDIR/vol0024_vis1.hdr
download https://zenodo.org/record/10492337/files/vol0025_vis1.cfl $RAWDIR/vol0025_vis1.cfl
download https://zenodo.org/record/10492337/files/vol0025_vis1.hdr $RAWDIR/vol0025_vis1.hdr
download https://zenodo.org/record/10492337/files/vol0027_vis1.cfl $RAWDIR/vol0027_vis1.cfl
download https://zenodo.org/record/10492337/files/vol0027_vis1.hdr $RAWDIR/vol0027_vis1.hdr
download https://zenodo.org/record/10492337/files/vol0032_vis1.cfl $RAWDIR/vol0032_vis1.cfl
download https://zenodo.org/record/10492337/files/vol0032_vis1.hdr $RAWDIR/vol0032_vis1.hdr
download https://zenodo.org/record/10492337/files/vol0034_vis1.cfl $RAWDIR/vol0034_vis1.cfl
download https://zenodo.org/record/10492337/files/vol0034_vis1.hdr $RAWDIR/vol0034_vis1.hdr

download https://zenodo.org/record/10492343/files/vol0035_vis1.cfl $RAWDIR/vol0035_vis1.cfl
download https://zenodo.org/record/10492343/files/vol0035_vis1.hdr $RAWDIR/vol0035_vis1.hdr
download https://zenodo.org/record/10492343/files/vol0036_vis1.cfl $RAWDIR/vol0036_vis1.cfl
download https://zenodo.org/record/10492343/files/vol0036_vis1.hdr $RAWDIR/vol0036_vis1.hdr
download https://zenodo.org/record/10492343/files/vol0037_vis1.cfl $RAWDIR/vol0037_vis1.cfl
download https://zenodo.org/record/10492343/files/vol0037_vis1.hdr $RAWDIR/vol0037_vis1.hdr
download https://zenodo.org/record/10492343/files/vol0038_vis1.cfl $RAWDIR/vol0038_vis1.cfl
download https://zenodo.org/record/10492343/files/vol0038_vis1.hdr $RAWDIR/vol0038_vis1.hdr
download https://zenodo.org/record/10492343/files/vol0039_vis1.cfl $RAWDIR/vol0039_vis1.cfl
download https://zenodo.org/record/10492343/files/vol0039_vis1.hdr $RAWDIR/vol0039_vis1.hdr
download https://zenodo.org/record/10492343/files/vol0040_vis1.cfl $RAWDIR/vol0040_vis1.cfl
download https://zenodo.org/record/10492343/files/vol0040_vis1.hdr $RAWDIR/vol0040_vis1.hdr
download https://zenodo.org/record/10492343/files/vol0041_vis1.cfl $RAWDIR/vol0041_vis1.cfl
download https://zenodo.org/record/10492343/files/vol0041_vis1.hdr $RAWDIR/vol0041_vis1.hdr
download https://zenodo.org/record/10492343/files/vol0043_vis1.cfl $RAWDIR/vol0043_vis1.cfl
download https://zenodo.org/record/10492343/files/vol0043_vis1.hdr $RAWDIR/vol0043_vis1.hdr
download https://zenodo.org/record/10492343/files/vol0044_vis1.cfl $RAWDIR/vol0044_vis1.cfl
download https://zenodo.org/record/10492343/files/vol0044_vis1.hdr $RAWDIR/vol0044_vis1.hdr
download https://zenodo.org/record/10492343/files/vol0045_vis1.cfl $RAWDIR/vol0045_vis1.cfl
download https://zenodo.org/record/10492343/files/vol0045_vis1.hdr $RAWDIR/vol0045_vis1.hdr
download https://zenodo.org/record/10492343/files/vol0046_vis1.cfl $RAWDIR/vol0046_vis1.cfl
download https://zenodo.org/record/10492343/files/vol0046_vis1.hdr $RAWDIR/vol0046_vis1.hdr
download https://zenodo.org/record/10492343/files/vol0047_vis1.cfl $RAWDIR/vol0047_vis1.cfl
download https://zenodo.org/record/10492343/files/vol0047_vis1.hdr $RAWDIR/vol0047_vis1.hdr
download https://zenodo.org/record/10492343/files/vol0048_vis1.cfl $RAWDIR/vol0048_vis1.cfl
download https://zenodo.org/record/10492343/files/vol0048_vis1.hdr $RAWDIR/vol0048_vis1.hdr
download https://zenodo.org/record/10492343/files/vol0049_vis1.cfl $RAWDIR/vol0049_vis1.cfl
download https://zenodo.org/record/10492343/files/vol0049_vis1.hdr $RAWDIR/vol0049_vis1.hdr

download https://zenodo.org/record/10492455/files/vol0051_vis1.cfl $RAWDIR/vol0051_vis1.cfl
download https://zenodo.org/record/10492455/files/vol0051_vis1.hdr $RAWDIR/vol0051_vis1.hdr
download https://zenodo.org/record/10492455/files/vol0052_vis1.cfl $RAWDIR/vol0052_vis1.cfl
download https://zenodo.org/record/10492455/files/vol0052_vis1.hdr $RAWDIR/vol0052_vis1.hdr
download https://zenodo.org/record/10492455/files/vol0053_vis1.cfl $RAWDIR/vol0053_vis1.cfl
download https://zenodo.org/record/10492455/files/vol0053_vis1.hdr $RAWDIR/vol0053_vis1.hdr
download https://zenodo.org/record/10492455/files/vol0054_vis1.cfl $RAWDIR/vol0054_vis1.cfl
download https://zenodo.org/record/10492455/files/vol0054_vis1.hdr $RAWDIR/vol0054_vis1.hdr
download https://zenodo.org/record/10492455/files/vol0055_vis1.cfl $RAWDIR/vol0055_vis1.cfl
download https://zenodo.org/record/10492455/files/vol0055_vis1.hdr $RAWDIR/vol0055_vis1.hdr
download https://zenodo.org/record/10492455/files/vol0056_vis1.cfl $RAWDIR/vol0056_vis1.cfl
download https://zenodo.org/record/10492455/files/vol0056_vis1.hdr $RAWDIR/vol0056_vis1.hdr
download https://zenodo.org/record/10492455/files/vol0057_vis1.cfl $RAWDIR/vol0057_vis1.cfl
download https://zenodo.org/record/10492455/files/vol0057_vis1.hdr $RAWDIR/vol0057_vis1.hdr
download https://zenodo.org/record/10492455/files/vol0058_vis1.cfl $RAWDIR/vol0058_vis1.cfl
download https://zenodo.org/record/10492455/files/vol0058_vis1.hdr $RAWDIR/vol0058_vis1.hdr
download https://zenodo.org/record/10492455/files/vol0059_vis1.cfl $RAWDIR/vol0059_vis1.cfl
download https://zenodo.org/record/10492455/files/vol0059_vis1.hdr $RAWDIR/vol0059_vis1.hdr
download https://zenodo.org/record/10492455/files/vol0060_vis1.cfl $RAWDIR/vol0060_vis1.cfl
download https://zenodo.org/record/10492455/files/vol0060_vis1.hdr $RAWDIR/vol0060_vis1.hdr
download https://zenodo.org/record/10492455/files/vol0061_vis1.cfl $RAWDIR/vol0061_vis1.cfl
download https://zenodo.org/record/10492455/files/vol0061_vis1.hdr $RAWDIR/vol0061_vis1.hdr
download https://zenodo.org/record/10492455/files/vol0062_vis1.cfl $RAWDIR/vol0062_vis1.cfl
download https://zenodo.org/record/10492455/files/vol0062_vis1.hdr $RAWDIR/vol0062_vis1.hdr
download https://zenodo.org/record/10492455/files/vol0066_vis1.cfl $RAWDIR/vol0066_vis1.cfl
download https://zenodo.org/record/10492455/files/vol0066_vis1.hdr $RAWDIR/vol0066_vis1.hdr
download https://zenodo.org/record/10492455/files/vol0067_vis1.cfl $RAWDIR/vol0067_vis1.cfl
download https://zenodo.org/record/10492455/files/vol0067_vis1.hdr $RAWDIR/vol0067_vis1.hdr

download https://zenodo.org/record/10493095/files/vol0069_vis1.cfl $RAWDIR/vol0069_vis1.cfl
download https://zenodo.org/record/10493095/files/vol0069_vis1.hdr $RAWDIR/vol0069_vis1.hdr
download https://zenodo.org/record/10493095/files/vol0070_vis1.cfl $RAWDIR/vol0070_vis1.cfl
download https://zenodo.org/record/10493095/files/vol0070_vis1.hdr $RAWDIR/vol0070_vis1.hdr
download https://zenodo.org/record/10493095/files/vol0071_vis1.cfl $RAWDIR/vol0071_vis1.cfl
download https://zenodo.org/record/10493095/files/vol0071_vis1.hdr $RAWDIR/vol0071_vis1.hdr
download https://zenodo.org/record/10493095/files/vol0072_vis1.cfl $RAWDIR/vol0072_vis1.cfl
download https://zenodo.org/record/10493095/files/vol0072_vis1.hdr $RAWDIR/vol0072_vis1.hdr
download https://zenodo.org/record/10493095/files/vol0077_vis1.cfl $RAWDIR/vol0077_vis1.cfl
download https://zenodo.org/record/10493095/files/vol0077_vis1.hdr $RAWDIR/vol0077_vis1.hdr
download https://zenodo.org/record/10493095/files/vol0078_vis1.cfl $RAWDIR/vol0078_vis1.cfl
download https://zenodo.org/record/10493095/files/vol0078_vis1.hdr $RAWDIR/vol0078_vis1.hdr
download https://zenodo.org/record/10493095/files/vol0079_vis1.cfl $RAWDIR/vol0079_vis1.cfl
download https://zenodo.org/record/10493095/files/vol0079_vis1.hdr $RAWDIR/vol0079_vis1.hdr
download https://zenodo.org/record/10493095/files/vol0080_vis1.cfl $RAWDIR/vol0080_vis1.cfl
download https://zenodo.org/record/10493095/files/vol0080_vis1.hdr $RAWDIR/vol0080_vis1.hdr
download https://zenodo.org/record/10493095/files/vol0082_vis1.cfl $RAWDIR/vol0082_vis1.cfl
download https://zenodo.org/record/10493095/files/vol0082_vis1.hdr $RAWDIR/vol0082_vis1.hdr
download https://zenodo.org/record/10493095/files/vol0083_vis1.cfl $RAWDIR/vol0083_vis1.cfl
download https://zenodo.org/record/10493095/files/vol0083_vis1.hdr $RAWDIR/vol0083_vis1.hdr
download https://zenodo.org/record/10493095/files/vol0084_vis1.cfl $RAWDIR/vol0084_vis1.cfl
download https://zenodo.org/record/10493095/files/vol0084_vis1.hdr $RAWDIR/vol0084_vis1.hdr
download https://zenodo.org/record/10493095/files/vol0087_vis1.cfl $RAWDIR/vol0087_vis1.cfl
download https://zenodo.org/record/10493095/files/vol0087_vis1.hdr $RAWDIR/vol0087_vis1.hdr

