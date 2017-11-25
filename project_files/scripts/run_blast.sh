#	BME5320
#	Robert Marini
#	project
#	runs blastp with the given input faa file

BLASTP='/Shared/class-BME5320-dkristensen/bin/blastp'

DB='/Shared/class-BME5320-dkristensen/database/refseq_protein'

QUERY_FILE=$1

OUTPUT_FILE="$1.out" #	suspect and untested

NUM_ALIGNMENTS_DESCR=500

TAB_FORMAT=6

#$BLASTP -query $QUERY_FILE -out $OUTPUT_FILE -db $DB -num_alignments $NUM_ALIGNMENTS_DESCR -num_descriptions $NUM_ALIGNMENTS_DESCR -outfmt $TAB_FORMAT


$BLASTP -query $QUERY_FILE -out $OUTPUT_FILE -db $DB -num_alignments $NUM_ALIGNMENTS_DESCR -max_target_seqs $NUM_ALIGNMENTS_DESCR -outfmt $TAB_FORMAT
