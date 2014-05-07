set -x
for ((deadline=30; deadline >= 1; deadline --))
do	
#	deadline=$deadline storage=S3 ampl model.ampl > deadline/$deadline-s3.yaml
	deadline=$deadline storage=CloudFiles ampl model.ampl > deadline/$deadline-cf.yaml
done

