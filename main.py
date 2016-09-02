'''
           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                   Version 2, December 2004

Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>

Everyone is permitted to copy and distribute verbatim or modified
copies of this license document, and changing it is allowed as long
as the name is changed.

           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

 0. You just DO WHAT THE FUCK YOU WANT TO.
'''


from datetime import datetime
from csv import DictReader
from math import exp, log, sqrt


# TL; DR, the main training process starts on line: 282,
# you may want to start reading the code from there


##############################################################################
# parameters #################################################################
##############################################################################

# A, paths
train = 'train_small.csv'               # path to training file
# B, model
alpha = .01  # learning rate
# C, feature/hash trick
D = 2 ** 20              # number of weights to use
do_interactions = False  # whether to enable poly2 feature interactions

# D, training/validation
epoch = 1      # learn training data for N passes
holdout = 100  # use every N training instance for holdout validation


##############################################################################
# class, function, generator definitions #####################################
##############################################################################

# each class below is a learning algorithm

class logistic_regression(object):
    ''' Classical logistic regression
    
        This class (algorithm) is not used in this code, it is putted here
        for a quick reference in hope to make the following (more complex)
        algorithm more understandable.
    '''

    def __init__(self, alpha, D, interaction=False):
        # parameters
        self.alpha = alpha

        # model
        self.w = [0.] * D

    def predict(self, x):
        # parameters
        alpha = self.alpha

        # model
        w = self.w

        # wTx is the inner product of w and x
        wTx = sum(w[i] for i in x)

        # bounded sigmoid function, this is the probability of being clicked
        return 1. / (1. + exp(-max(min(wTx, 35.), -35.)))

    def update(self, x, p, y):
        # parameter
        alpha = self.alpha

        # model
        w = self.w

        # gradient under logloss
        g = p - y

        # update w
        for i in x:
            w[i] -= g * alpha


def logloss(p, y):
    ''' FUNCTION: Bounded logloss

        INPUT:
            p: our prediction
            y: real answer

        OUTPUT:
            logarithmic loss of p given y
    '''

    # p = max(min(p, 1. - 10e-15), 10e-15)
    return -log(p) if y == 1. else -log(1. - p)


def data(path, D):
    ''' GENERATOR: Apply hash-trick to the original csv row
                   and for simplicity, we one-hot-encode everything

        INPUT:
            path: path to training or testing file
            D: the max index that we can hash to

        YIELDS:
            ID: id of the instance, mainly useless
            x: a list of hashed and one-hot-encoded 'indices'
               we only need the index since all values are either 0 or 1
            y: y = 1 if we have a click, else we have y = 0
    '''

    for t, row in enumerate(DictReader(open(path))):
        # process id
        ID = row['id']
        del row['id']

        # process clicks
        y = 0.
        if 'click' in row:
            if row['click'] == '1':
                y = 1.
            del row['click']

        # turn hour really into hour, it was originally YYMMDDHH
        #row['hour'] = row['hour'][6:]

        # build x
        x = [0]  # 0 is the index of the bias term
        #for key in sorted(row):  # sort is for preserving feature ordering
        for key in row:
	    value = row[key]

            # one-hot encode everything with hash trick
            # index = abs(hash(key + '_' + value)) % D
            index = abs(hash(key  + value)) % D
            x.append(index)

        yield t, ID, x, y


##############################################################################
# start training #############################################################
##############################################################################

start = datetime.now()

# initialize ourselves a learner
learner = logistic_regression(alpha, D)

# start training
for e in xrange(epoch):
    loss = 0.
    count = 0

    for t, ID, x, y in data(train, D):  # data is a generator
        #  t: just a instance counter
        # ID: id provided in original data
        #  x: features
        #  y: label (click)

        # step 1, get prediction from learner
        p = learner.predict(x)

        if t % holdout == 0:
            # step 2-1, calculate holdout validation loss
            #           we do not train with the holdout data so that our
            #           validation loss is an accurate estimation of
            #           the out-of-sample error
            loss += logloss(p, y)
            count += 1
        else:
            # step 2-2, update learner with label (click) information
            learner.update(x, p, y)

        if t % 1000000 == 0 and t > 1:
            print(' %s\tencountered: %d\tcurrent logloss: %f' % (
                datetime.now(), t, loss/count))

    print('Epoch %d finished, holdout logloss: %f, elapsed time: %s' % (
        e, loss/count, str(datetime.now() - start)))

