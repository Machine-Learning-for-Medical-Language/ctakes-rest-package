import sys
from glob import glob
from ctakes_rest import process_sentence

def main(args):
    if len(args) < 2:
        sys.stderr.write('2 required arguments: <input dir> <output file>\n')
        sys.exit(-1)

    with open(args[1], 'wt') as fout:
        for filename in glob('%s/*.txt' % (args[0]) ):
            with open(filename) as f:
                text = f.read()
                cuis = process_sentence(text)

                fout.write('%s:' % (filename) )                
                for cui_entry in cuis:
                    fout.write(' %s' % (cui_entry[0]) )
                fout.write('\n')
 


if __name__ == '__main__':
    main(sys.argv[1:])
