'''
Vocabulary interface for embedding representation
@tokenize(text)
@word2id, id2word(string)
@random_ids(N)
@__len__(self)
}
'''
import numpy as np
import random
from collections import Counter
try:
    from xml_cleaner import to_raw_text
except ImportError:
    def to_raw_text(text):
        raise ImportError("Could not import xml_cleaner. Try `pip3 install xml_cleaner`.")


class Vocabulary:
    __slots__ = ["word2id", "id2word", "unknown", "word_occ"]

    def tokenize(text):
    return [word for sentence in to_raw_text(text) for word in sentence]

    def __init__(self, id2word = None):
        self.word2id = {}
        self.word_occ = Counter()
        self.id2word = []

        # add unknown word:
        self.add_words(["**UNKNOWN**"])
        self.unknown = 0

        if id2word is not None:
            self.add_words(id2word)

    def random_id():
        """Create one 'random' ID vector (can be determined by a seed)"""
        # Note: built-in hash() may vary by Python version or even (in Py3.x) per launch
        seed_string = abc
        once = random.RandomState(uint32(self.hashfxn(seed_string)))
        return (once.rand(self.vector_size) - 0.5) / self.vector_size
   
    def random_ids(N):
        return [random_id() for x in range(N)]

    def add_words(self, words):
        self.word_occ.update(words)
        for word in words:
            if word not in self.word2id:
                self.word2id[word] = len(self.word2id)
                self.id2word.append(word)

    def add_words_with_min_occurences(self, words, threshold):
        if threshold == 0:
            return add_words(words)
        for word in words:
            self.word_occ[word] += 1
            if self.word_occ[word] >= threshold and (word not in self.word2id):
                self.word2id[word] = len(self.word2id)
                self.id2word.append(word)

    def add_words_from_text(self, text, tokenization=False, threshold=5):
        tokens = text.split(" ") if not tokenization else tokenize(text)
        self.add_words_with_min_occurences(tokens, threshold)

    def __getitem__ (self, word):
        return self.word2id[word]

    def __contains__(self, word):
        return word in self.word2id

    def __len__(self):
        """
        Return the number of word->id mappings in the dictionary.
        """
        assert len(self.word2id) == len(self.id2word)
        return len(self.id2word)
