#~/Documents/SKOOL/Informatics/Fall2017\ Classes/BME_Bioinformatics\ Techniques/final\ project
#~/BME5320/project/project_files/scripts/get-split-MGG-genome.sh

#meant to be run on neon
module load python/3.3

#mainly for documenting command flow and NOT a runable shell script

compressed_file="../data/compressed_input_file.faa.gz"
file="../data/uncompressed_input_file.faa"

#*******************************
#uncomment for production:
echo "[INFO] wget -P $compressed_file ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/027/325/GCF_000027325.1_ASM2732v1/GCF_000027325.1_ASM2732v1_protein.faa.gz"
wget -O $compressed_file ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/027/325/GCF_000027325.1_ASM2732v1/GCF_000027325.1_ASM2732v1_protein.faa.gz
#*******************************

if [ ! -d "../data" ]; then
	mkdir "../data"
fi

gunzip -c $compressed_file > $file #the result is the uncompressed_input_file.faa

n=$(grep ">" $file | wc -l) #we know this to be 515, but this checks just to make sure

#finding factors
factors=$(./factor.sh $n) #returns 5 and 103 in an array

max_factor=0
max_factor_i=0
i=0
for factor in $factors
do
	if (($factor > $max_factor)); then
		max_factor=$factor
		max_factor_i=$i
	fi
	i=$(($i + 1))
done

num_of_files=$max_factor
num_of_seqs=$(($n / $max_factor))

#from here we can split the $compressed_file into 103 files with 5 sequences
echo "[INFO] Found best prime factors to split input file into: $num_of_seqs sequences per file of $num_of_files files."

#check if dir exists, if not, create it
if [ ! -d "../data/faa-split" ]; then
	mkdir "../data/faa-split"
fi

echo "[INFO] Creating files by running auxillary python script."
echo "[INFO] It is assumed that the python file is in the current working directory."
split_status=0
python split_faa.py $file $num_of_files $num_of_seqs > $split_status #5 seqences into each of the 103 files, it

if (($split_status > 0)); then
	exit 1
else
	echo "[INFO] File split successful."
fi

#	actual qsub here, untested
#qsub -t 0-num_of_files:1 submit_blast_array.job
qsub -t 0-2:1 submit_blast_array.job	#for dev only













