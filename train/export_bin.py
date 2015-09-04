import codecs
from gensim.models import Word2Vec

def main():
    path_to_model = 'GoogleNews-vectors-negative300.bin'
    output_file = 'GoogleNews-vectors-negative300.txt'
    export_to_file(path_to_model, output_file)


def export_to_file(path_to_model, output_file):
    output = codecs.open(output_file, 'w' , 'utf-8')
    model = Word2Vec.load_word2vec_format(path_to_model, binary=True)
    print('done loading Word2Vec')
    vocab = model.vocab
    for mid in vocab:
        #print(model[mid])
        #print(mid)
        vector = list()
        for dimension in model[mid]:
            vector.append(str(dimension))
        #line = { "mid": mid, "vector": vector  }
        vector_str = ",".join(vector)
        line = mid + "\t"  + vector_str
        #line = json.dumps(line)
        output.write(line + "\n")
    output.close()

if __name__ == "__main__":
    main()
    #cProfile.run('main()') # if you want to do some profiling