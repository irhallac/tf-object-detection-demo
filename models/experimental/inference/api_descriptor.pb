
�
%tensorflow/core/example/feature.proto
tensorflow"!
	BytesList
value (Rvalue"%
	FloatList
value (BRvalue"%
	Int64List
value (BRvalue"�
Feature6

bytes_list (2.tensorflow.BytesListH R	bytesList6

float_list (2.tensorflow.FloatListH R	floatList6

int64_list (2.tensorflow.Int64ListH R	int64ListB
kind"�
Features;
feature (2!.tensorflow.Features.FeatureEntryRfeatureO
FeatureEntry
key (	Rkey)
value (2.tensorflow.FeatureRvalue:8"<
FeatureList-
feature (2.tensorflow.FeatureRfeature"�
FeatureListsL
feature_list (2).tensorflow.FeatureLists.FeatureListEntryRfeatureListW
FeatureListEntry
key (	Rkey-
value (2.tensorflow.FeatureListRvalue:8Bi
org.tensorflow.exampleBFeatureProtosPZ;github.com/tensorflow/tensorflow/tensorflow/go/core/example�J�
7 h
�
7 2� Protocol messages for describing features for machine learning model
 training or inference.

 There are three base Feature types:
   - bytes
   - float
   - int64

 A Feature contains Lists which may hold zero or more values.  These
 lists are the base values BytesList, FloatList, Int64List.

 Features are organized into categories by name.  The Features message
 contains the mapping from name to Feature.

 Example Features for a movie recommendation application:
   feature {
     key: "age"
     value { float_list {
       value: 29.0
     }}
   }
   feature {
     key: "movie"
     value { bytes_list {
       value: "The Shawshank Redemption"
       value: "Fight Club"
     }}
   }
   feature {
     key: "movie_ratings"
     value { float_list {
       value: 9.0
       value: 9.7
     }}
   }
   feature {
     key: "suggestion"
     value { bytes_list {
       value: "Inception"
     }}
   }
   feature {
     key: "suggestion_purchased"
     value { int64_list {
       value: 1
     }}
   }
   feature {
     key: "purchase_price"
     value { float_list {
       value: 9.99
     }}
   }



8 
	
8 

9 .
	
9 .

: "
	

: "

; /
	
; /

< R
	
< R

=
=
 @ B1 Containers to hold repeated fundamental values.



 @

  A

  A


  A

  A

  A


C E


C

 D+

 D


 D

 D

 D

 D*

 D)


F H


F

 G+

 G


 G

 G

 G

 G*

 G)
1
K R% Containers for non-sequential data.



K
5
 MQ' Each feature can be exactly one kind.


 M

 N

 N

 N

 N

O

O

O

O

P

P

P

P


T W


T
0
 V## Map from feature name to feature.


 VT

 V

 V

 V!"
�
a c� Containers for sequential data.

 A FeatureList contains lists of Features.  These may hold zero or more
 Feature values.

 FeatureLists are organized into categories by name.  The FeatureLists message
 contains the mapping from name to FeatureList.




a

 b

 b


 b

 b

 b


e h


e
5
 g,( Map from feature name to feature list.


 ge

 g

 g'

 g*+bproto3
�R
%tensorflow/core/example/example.proto
tensorflow%tensorflow/core/example/feature.proto";
Example0
features (2.tensorflow.FeaturesRfeatures"�
SequenceExample.
context (2.tensorflow.FeaturesRcontext=
feature_lists (2.tensorflow.FeatureListsRfeatureListsBi
org.tensorflow.exampleBExampleProtosPZ;github.com/tensorflow/tensorflow/tensorflow/go/core/example�J�O
 �
s
 i Protocol messages for describing input data Examples for machine learning
 model training or inference.

	
 .

 
	
 

 .
	
 .

 "
	

 "

 /
	
 /

	 R
	
	 R



�
 W Y2� An Example is a mostly-normalized data format for storing data for
 training and inference.  It contains a key-value store (features); where
 each key (string) maps to a Feature message (which is oneof packed BytesList,
 FloatList, or Int64List).  This flexible and compact format allows the
 storage of large amounts of typed data, but requires that the data shape
 and use be determined by the configuration files and parsers that are used to
 read and write this format.  That is, the Example is mostly *not* a
 self-describing format.  In TensorFlow, Examples are read in row-major
 format, so any configuration that describes data with rank-2 or above
 should keep this in mind.  For example, to store an M x N matrix of Bytes,
 the BytesList must contain M*N bytes, with M rows of N contiguous values
 each.  That is, the BytesList value must store the matrix as:
     .... row 0 .... .... row 1 .... // ...........  // ... row M-1 ....

 An Example for a movie recommendation application:
   features {
     feature {
       key: "age"
       value { float_list {
         value: 29.0
       }}
     }
     feature {
       key: "movie"
       value { bytes_list {
         value: "The Shawshank Redemption"
         value: "Fight Club"
       }}
     }
     feature {
       key: "movie_ratings"
       value { float_list {
         value: 9.0
         value: 9.7
       }}
     }
     feature {
       key: "suggestion"
       value { bytes_list {
         value: "Inception"
       }}
     }
     # Note that this feature exists to be used as a label in training.
     # E.g., if training a logistic regression model to predict purchase
     # probability in our learning tool we would set the label feature to
     # "suggestion_purchased".
     feature {
       key: "suggestion_purchased"
       value { float_list {
         value: 1.0
       }}
     }
     # Similar to "suggestion_purchased" above this feature exists to be used
     # as a label in training.
     # E.g., if training a linear regression model to predict purchase
     # price in our learning tool we would set the label feature to
     # "purchase_price".
     feature {
       key: "purchase_price"
       value { float_list {
         value: 9.99
       }}
     }
  }

 A conformant Example data set obeys the following conventions:
   - If a Feature K exists in one example with data type T, it must be of
       type T in all other examples when present. It may be omitted.
   - The number of instances of Feature K list data may vary across examples,
       depending on the requirements of the model.
   - If a Feature K doesn't exist in an example, a K-specific default will be
       used, if configured.
   - If a Feature K exists in an example but contains no items, the intent
       is considered to be an empty tensor and no default will be used.



 W

  X

  XW

  X


  X

  X
�5
� �2�4 A SequenceExample is an Example representing one or more sequences, and
 some context.  The context contains features which apply to the entire
 example. The feature_lists contain a key, value map where each key is
 associated with a repeated set of Features (a FeatureList).
 A FeatureList thus represents the values of a feature identified by its key
 over time / frames.

 Below is a SequenceExample for a movie recommendation application recording a
 sequence of ratings by a user. The time-independent features ("locale",
 "age", "favorites") describing the user are part of the context. The sequence
 of movies the user rated are part of the feature_lists. For each movie in the
 sequence we have information on its name and actors and the user's rating.
 This information is recorded in three separate feature_list(s).
 In the example below there are only two movies. All three feature_list(s),
 namely "movie_ratings", "movie_names", and "actors" have a feature value for
 both movies. Note, that "actors" is itself a bytes_list with multiple
 strings per movie.

 context: {
   feature: {
     key  : "locale"
     value: {
       bytes_list: {
         value: [ "pt_BR" ]
       }
     }
   }
   feature: {
     key  : "age"
     value: {
       float_list: {
         value: [ 19.0 ]
       }
     }
   }
   feature: {
     key  : "favorites"
     value: {
       bytes_list: {
         value: [ "Majesty Rose", "Savannah Outen", "One Direction" ]
       }
     }
   }
 }
 feature_lists: {
   feature_list: {
     key  : "movie_ratings"
     value: {
       feature: {
         float_list: {
           value: [ 4.5 ]
         }
       }
       feature: {
         float_list: {
           value: [ 5.0 ]
         }
       }
     }
   }
   feature_list: {
     key  : "movie_names"
     value: {
       feature: {
         bytes_list: {
           value: [ "The Shawshank Redemption" ]
         }
       }
       feature: {
         bytes_list: {
           value: [ "Fight Club" ]
         }
       }
     }
   }
   feature_list: {
     key  : "actors"
     value: {
       feature: {
         bytes_list: {
           value: [ "Tim Robbins", "Morgan Freeman" ]
         }
       }
       feature: {
         bytes_list: {
           value: [ "Brad Pitt", "Edward Norton", "Helena Bonham Carter" ]
         }
       }
     }
   }
 }

 A conformant SequenceExample data set obeys the following conventions:

 Context:
   - All conformant context features K must obey the same conventions as
     a conformant Example's features (see above).
 Feature lists:
   - A FeatureList L may be missing in an example; it is up to the
     parser configuration to determine if this is allowed or considered
     an empty list (zero length).
   - If a FeatureList L exists, it may be empty (zero length).
   - If a FeatureList L is non-empty, all features within the FeatureList
     must have the same data type T. Even across SequenceExamples, the type T
     of the FeatureList identified by the same key must be the same. An entry
     without any values may serve as an empty feature.
   - If a FeatureList L is non-empty, it is up to the parser configuration
     to determine if all features within the FeatureList must
     have the same size.  The same holds for this FeatureList across multiple
     examples.
   - For sequence modeling, e.g.:
        http://colah.github.io/posts/2015-08-Understanding-LSTMs/
        https://github.com/tensorflow/nmt
     the feature lists represent a sequence of frames.
     In this scenario, all FeatureLists in a SequenceExample have the same
     number of Feature messages, so that the ith element in each FeatureList
     is part of the ith frame (or time step).
 Examples of conformant and non-conformant examples' FeatureLists:

 Conformant FeatureLists:
    feature_lists: { feature_list: {
      key: "movie_ratings"
      value: { feature: { float_list: { value: [ 4.5 ] } }
               feature: { float_list: { value: [ 5.0 ] } } }
    } }

 Non-conformant FeatureLists (mismatched types):
    feature_lists: { feature_list: {
      key: "movie_ratings"
      value: { feature: { float_list: { value: [ 4.5 ] } }
               feature: { int64_list: { value: [ 5 ] } } }
    } }

 Conditionally conformant FeatureLists, the parser configuration determines
 if the feature sizes must match:
    feature_lists: { feature_list: {
      key: "movie_ratings"
      value: { feature: { float_list: { value: [ 4.5 ] } }
               feature: { float_list: { value: [ 5.0, 6.0 ] } } }
    } }

 Conformant pair of SequenceExample
    feature_lists: { feature_list: {
      key: "movie_ratings"
      value: { feature: { float_list: { value: [ 4.5 ] } }
               feature: { float_list: { value: [ 5.0 ] } } }
    } }
 and:
    feature_lists: { feature_list: {
      key: "movie_ratings"
      value: { feature: { float_list: { value: [ 4.5 ] } }
               feature: { float_list: { value: [ 5.0 ] } }
               feature: { float_list: { value: [ 2.0 ] } } }
    } }

 Conformant pair of SequenceExample
    feature_lists: { feature_list: {
      key: "movie_ratings"
      value: { feature: { float_list: { value: [ 4.5 ] } }
               feature: { float_list: { value: [ 5.0 ] } } }
    } }
 and:
    feature_lists: { feature_list: {
      key: "movie_ratings"
      value: { }
    } }

 Conditionally conformant pair of SequenceExample, the parser configuration
 determines if the second feature_lists is consistent (zero-length) or
 invalid (missing "movie_ratings"):
    feature_lists: { feature_list: {
      key: "movie_ratings"
      value: { feature: { float_list: { value: [ 4.5 ] } }
               feature: { float_list: { value: [ 5.0 ] } } }
    } }
 and:
    feature_lists: { }

 Non-conformant pair of SequenceExample (mismatched types)
    feature_lists: { feature_list: {
      key: "movie_ratings"
      value: { feature: { float_list: { value: [ 4.5 ] } }
               feature: { float_list: { value: [ 5.0 ] } } }
    } }
 and:
    feature_lists: { feature_list: {
      key: "movie_ratings"
      value: { feature: { int64_list: { value: [ 4 ] } }
               feature: { int64_list: { value: [ 5 ] } }
               feature: { int64_list: { value: [ 2 ] } } }
    } }

 Conditionally conformant pair of SequenceExample; the parser configuration
 determines if the feature sizes must match:
    feature_lists: { feature_list: {
      key: "movie_ratings"
      value: { feature: { float_list: { value: [ 4.5 ] } }
               feature: { float_list: { value: [ 5.0 ] } } }
    } }
 and:
    feature_lists: { feature_list: {
      key: "movie_ratings"
      value: { feature: { float_list: { value: [ 4.0 ] } }
               feature: { float_list: { value: [ 5.0, 3.0 ] } }
    } }


�

 �

 ��

 �


 �

 �

�!

��

�

�

� bproto3
�
#tensorflow_serving/apis/input.prototensorflow.serving%tensorflow/core/example/example.proto">
ExampleList/
examples (2.tensorflow.ExampleRexamples"x
ExampleListWithContext/
examples (2.tensorflow.ExampleRexamples-
context (2.tensorflow.ExampleRcontext"�
InputH
example_list (2.tensorflow.serving.ExampleListB(H RexampleListk
example_list_with_context (2*.tensorflow.serving.ExampleListWithContextB(H RexampleListWithContextB
kindB�J�
 K
l
 2b Input used in serving APIs.  Based on the tensorflow.Example family of
 feature representations.


 
	
 
	
 .

	
�
  � Specifies one or more fully independent input Examples.
 See examples at:
     https://github.com/tensorflow/tensorflow/blob/master/tensorflow/core/example/example.proto



 

  +

  


  

  &

  )*
�
A D� Specifies one or more independent input Examples, with a common context
 Example.

 The common use case for context is to cleanly and optimally specify some
 features that are common across multiple examples.

 See example below with a search query as the context and multiple restaurants
 to perform some inference on.

 context: {
   feature: {
     key  : "query"
     value: {
       bytes_list: {
         value: [ "pizza" ]
       }
     }
   }
 }
 examples: {
   feature: {
     key  : "cuisine"
     value: {
       bytes_list: {
         value: [ "Pizzeria" ]
       }
     }
   }
 }
 examples: {
   feature: {
     key  : "cuisine"
     value: {
       bytes_list: {
         value: [ "Taqueria" ]
       }
     }
   }
 }

 Implementations of ExampleListWithContext merge the context Example into each
 of the Examples. Note that feature keys must not be duplicated between the
 Examples and context Example, or the behavior is undefined.

 See also:
     tensorflow/core/example/example.proto
     https://developers.google.com/protocol-buffers/docs/proto3#maps



A

 B+

 B


 B

 B&

 B)*

C!

CB+

C

C

C 


F K


F

 GJ

 G

 H/

 H

 H

 H 

 H!.

 H"-

IG

I

I4

I78

I9F

I:Ebproto3
�"
google/protobuf/wrappers.protogoogle.protobuf"#
DoubleValue
value (Rvalue""

FloatValue
value (Rvalue""

Int64Value
value (Rvalue"#
UInt64Value
value (Rvalue""

Int32Value
value (Rvalue"#
UInt32Value
value (Rvalue"!
	BoolValue
value (Rvalue"#
StringValue
value (	Rvalue""

BytesValue
value (RvalueB|
com.google.protobufBWrappersProtoPZ*github.com/golang/protobuf/ptypes/wrappers��GPB�Google.Protobuf.WellKnownTypesJ�
# u
�
# 2� Protocol Buffers - Google's data interchange format
 Copyright 2008 Google Inc.  All rights reserved.
 https://developers.google.com/protocol-buffers/

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are
 met:

     * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
     * Redistributions in binary form must reproduce the above
 copyright notice, this list of conditions and the following disclaimer
 in the documentation and/or other materials provided with the
 distribution.
     * Neither the name of Google Inc. nor the names of its
 contributors may be used to endorse or promote products derived from
 this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
2� Wrappers for primitive (non-message) types. These types are useful
 for embedding primitives in the `google.protobuf.Any` type and for places
 where we need to distinguish between the absence of a primitive
 typed field and its default value.


%

' ;
	
%' ;

( 
	
( 

) A
	
) A

* ,
	
* ,

+ .
	
+ .

, "
	

, "

- !
	
$- !
g
 2 5[ Wrapper message for `double`.

 The JSON representation for `DoubleValue` is JSON number.



 2
 
  4 The double value.


  42

  4

  4	

  4
e
: =Y Wrapper message for `float`.

 The JSON representation for `FloatValue` is JSON number.



:

 < The float value.


 <:

 <

 <

 <
e
B EY Wrapper message for `int64`.

 The JSON representation for `Int64Value` is JSON string.



B

 D The int64 value.


 DB

 D

 D

 D
g
J M[ Wrapper message for `uint64`.

 The JSON representation for `UInt64Value` is JSON string.



J
 
 L The uint64 value.


 LJ

 L

 L	

 L
e
R UY Wrapper message for `int32`.

 The JSON representation for `Int32Value` is JSON number.



R

 T The int32 value.


 TR

 T

 T

 T
g
Z ][ Wrapper message for `uint32`.

 The JSON representation for `UInt32Value` is JSON number.



Z
 
 \ The uint32 value.


 \Z

 \

 \	

 \
o
b ec Wrapper message for `bool`.

 The JSON representation for `BoolValue` is JSON `true` and `false`.



b

 d The bool value.


 db

 d

 d

 d
g
j m[ Wrapper message for `string`.

 The JSON representation for `StringValue` is JSON string.



j
 
 l The string value.


 lj

 l

 l	

 l
e
r uY Wrapper message for `bytes`.

 The JSON representation for `BytesValue` is JSON string.



r

 t The bytes value.


 tr

 t

 t

 tbproto3
�

#tensorflow_serving/apis/model.prototensorflow.servinggoogle/protobuf/wrappers.proto"�
	ModelSpec
name (	Rname7
version (2.google.protobuf.Int64ValueH Rversion%
version_label (	H RversionLabel%
signature_name (	RsignatureNameB
version_choiceB�J�
   

  



 
	
 
	
 '
S
   G Metadata for an inference request such as the model name and version.



 
&
  
 Required servable name.


  


  


  
	

  

�
  � Optional choice of which version of the model to use.

 Recommended to be left unset in the common case. Should be specified only
 when there is a strong version consistency requirement.

 When left unspecified, the system will serve the best available version.
 This is typically the latest version, though during version transitions,
 notably when serving on a fleet of instances, may be either the previous or
 new version.


  
0
 +# Use this specific version number.


 

 &

 )*
?
 2 Use the version associated with the given label.


 


 

 
b
 U A named signature to evaluate. If unspecified, the default signature will
 be used.


 

 

 	

 bproto3
�
,tensorflow_serving/apis/classification.prototensorflow.serving#tensorflow_serving/apis/input.proto#tensorflow_serving/apis/model.proto"3
Class
label (	Rlabel
score (Rscore"F
Classifications3
classes (2.tensorflow.serving.ClassRclasses"e
ClassificationResultM
classifications (2#.tensorflow.serving.ClassificationsRclassifications"�
ClassificationRequest<

model_spec (2.tensorflow.serving.ModelSpecR	modelSpec/
input (2.tensorflow.serving.InputRinput"�
ClassificationResponse<

model_spec (2.tensorflow.serving.ModelSpecR	modelSpec@
result (2(.tensorflow.serving.ClassificationResultRresultB�J�

  /

  

 
	
 
	
 ,
	
,



 
  A single class.



 

*
   Label or name of the class.


  


  

  	

  
�
 � Score for this class (e.g., the probability the item belongs to this
 class). As per the proto3 default-value semantics, if the score is missing,
 it should be treated as 0.


 

 

 

 
E
 9 List of classes for a single item (tensorflow.Example).





 

 


 

 

 
n
 b Contains one result per input example, in the same order as the input in
 ClassificationRequest.





 /

 


 

 *

 -.

  '2 RPC Interfaces



 
j
 #] Model Specification. If version is not specified, will use the latest
 (numerical) version.


 # 

 #

 #

 #

&% Input data.


&#

&

& 

&#$


) /


)
E
 +8 Effective Model Specification used for classification.


 +) 

 +

 +

 +
,
." Result of the classification.


.+

.

.

. !bproto3
�,
google/protobuf/any.protogoogle.protobuf"6
Any
type_url (	RtypeUrl
value (RvalueBo
com.google.protobufBAnyProtoPZ%github.com/golang/protobuf/ptypes/any�GPB�Google.Protobuf.WellKnownTypesJ�*
 �
�
 2� Protocol Buffers - Google's data interchange format
 Copyright 2008 Google Inc.  All rights reserved.
 https://developers.google.com/protocol-buffers/

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are
 met:

     * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
     * Redistributions in binary form must reproduce the above
 copyright notice, this list of conditions and the following disclaimer
 in the documentation and/or other materials provided with the
 distribution.
     * Neither the name of Google Inc. nor the names of its
 contributors may be used to endorse or promote products derived from
 this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


 

" ;
	
%" ;

# <
	
# <

$ ,
	
$ ,

% )
	
% )

& "
	

& "

' !
	
$' !
�
 y �� `Any` contains an arbitrary serialized protocol buffer message along with a
 URL that describes the type of the serialized message.

 Protobuf library provides support to pack/unpack Any values in the form
 of utility functions or additional generated methods of the Any type.

 Example 1: Pack and unpack a message in C++.

     Foo foo = ...;
     Any any;
     any.PackFrom(foo);
     ...
     if (any.UnpackTo(&foo)) {
       ...
     }

 Example 2: Pack and unpack a message in Java.

     Foo foo = ...;
     Any any = Any.pack(foo);
     ...
     if (any.is(Foo.class)) {
       foo = any.unpack(Foo.class);
     }

  Example 3: Pack and unpack a message in Python.

     foo = Foo(...)
     any = Any()
     any.Pack(foo)
     ...
     if any.Is(Foo.DESCRIPTOR):
       any.Unpack(foo)
       ...

  Example 4: Pack and unpack a message in Go

      foo := &pb.Foo{...}
      any, err := ptypes.MarshalAny(foo)
      ...
      foo := &pb.Foo{}
      if err := ptypes.UnmarshalAny(any, foo); err != nil {
        ...
      }

 The pack methods provided by protobuf library will by default use
 'type.googleapis.com/full.type.name' as the type URL and the unpack
 methods only use the fully qualified type name after the last '/'
 in the type URL, for example "foo.bar.com/x/y.z" will yield type
 name "y.z".


 JSON
 ====
 The JSON representation of an `Any` value uses the regular
 representation of the deserialized, embedded message, with an
 additional field `@type` which contains the type URL. Example:

     package google.profile;
     message Person {
       string first_name = 1;
       string last_name = 2;
     }

     {
       "@type": "type.googleapis.com/google.profile.Person",
       "firstName": <string>,
       "lastName": <string>
     }

 If the embedded message type is well-known and has a custom JSON
 representation, that representation will be embedded adding a field
 `value` which holds the custom JSON in addition to the `@type`
 field. Example (for message [google.protobuf.Duration][]):

     {
       "@type": "type.googleapis.com/google.protobuf.Duration",
       "value": "1.212s"
     }




 y
�

  ��
 A URL/resource name that uniquely identifies the type of the serialized
 protocol buffer message. The last segment of the URL's path must represent
 the fully qualified name of the type (as in
 `path/google.protobuf.Duration`). The name should be in a canonical form
 (e.g., leading "." is not accepted).

 In practice, teams usually precompile into the binary all types that they
 expect it to use in the context of Any. However, for URLs which use the
 scheme `http`, `https`, or no scheme, one can optionally set up a type
 server that maps type URLs to message definitions as follows:

 * If no scheme is provided, `https` is assumed.
 * An HTTP GET on the URL must yield a [google.protobuf.Type][]
   value in binary format, or produce an error.
 * Applications are allowed to cache lookup results based on the
   URL, or have them precompiled into a binary to avoid any
   lookup. Therefore, binary compatibility needs to be preserved
   on changes to types. (Use versioned type names to manage
   breaking changes.)

 Note: this functionality is not currently available in the official
 protobuf release, and it is not used for type URLs beginning with
 type.googleapis.com.

 Schemes other than `http`, `https` (or the empty scheme) might be
 used with implementation specific semantics.



  �y

  �

  �	

  �
W
 �I Must be a valid serialized protocol buffer of the above specified type.


 ��

 �

 �

 �bproto3
�

/tensorflow/core/framework/resource_handle.proto
tensorflow"�
ResourceHandleProto
device (	Rdevice
	container (	R	container
name (	Rname
	hash_code (RhashCode&
maybe_type_name (	RmaybeTypeNameBn
org.tensorflow.frameworkBResourceHandlePZ=github.com/tensorflow/tensorflow/tensorflow/go/core/framework�J�
  

  



 
	
 

 /
	
 /

 "
	

 "

 1
	
 1

 T
	
 T
�
  � Protocol buffer representing a handle to a tensorflow resource. Handles are
 not valid across executions, but can be serialized back and forth from within
 a single run.



 
B
  5 Unique name for the device containing the resource.


  

  

  	

  
:
 - Container in which this resource is placed.


 

 

 	

 
,
  Unique name of this resource.


 

 

 	

 
s
 f Hash code for the type of the resource. Is only valid in the same device
 and in the same execution.


 

 

 	

 
]
 P For debug-only, the name of the type pointed to by this handle, if
 available.


 

 

 	

 bproto3
�
,tensorflow/core/framework/tensor_shape.proto
tensorflow"�
TensorShapeProto2
dim (2 .tensorflow.TensorShapeProto.DimRdim!
unknown_rank (RunknownRank-
Dim
size (Rsize
name (	RnameBq
org.tensorflow.frameworkBTensorShapeProtosPZ=github.com/tensorflow/tensorflow/tensorflow/go/core/framework�J�
 -
>
 24 Protocol buffer representing the shape of tensors.


 
	
 

 2
	
 2

 "
	

 "

 1
	
 1

 T
	
 T

	
%
  - Dimensions of a tensor.



 
,
   One dimension of the tensor.


  

�
   � Size of the tensor in that dimension.
 This value must be >= -1, but values of -1 are reserved for "unknown"
 shapes (values of -1 mean "unknown" dimension).  Certain wrappers
 that work with TensorShapeProto may fail at runtime when deserializing
 a TensorShapeProto containing a dim value of -1.


   

   	

   


   
7
  ( Optional name of the tensor dimension.


  

  


  

  
�
  '� Dimensions of the tensor, such as {"input", 30}, {"output", 40}
 for a 30 x 40 2D tensor.  If an entry has size -1, this
 corresponds to a dimension of unknown size. The names are
 optional.

 The order of entries in "dim" matters: It indicates the layout of the
 values in the tensor in-memory representation.

 The first entry in "dim" is the outermost dimension used to layout the
 values, the last entry is the innermost dimension.  This matches the
 in-memory layout of RowMajor Eigen tensors.

 If "dim.size()" > 0, "unknown_rank" must be false.


  '


  '

  '

  '
l
 ,_ If true, the number of dimensions in the shape is unknown.

 If true, "dim.size()" must be 0.


 ,'

 ,

 ,

 ,bproto3
�
%tensorflow/core/framework/types.proto
tensorflow*�
DataType

DT_INVALID 
DT_FLOAT
	DT_DOUBLE
DT_INT32
DT_UINT8
DT_INT16
DT_INT8
	DT_STRING
DT_COMPLEX64
DT_INT64	
DT_BOOL

DT_QINT8
	DT_QUINT8
	DT_QINT32
DT_BFLOAT16
	DT_QINT16

DT_QUINT16
	DT_UINT16
DT_COMPLEX128
DT_HALF
DT_RESOURCE

DT_VARIANT
	DT_UINT32
	DT_UINT64
DT_FLOAT_REFe
DT_DOUBLE_REFf
DT_INT32_REFg
DT_UINT8_REFh
DT_INT16_REFi
DT_INT8_REFj
DT_STRING_REFk
DT_COMPLEX64_REFl
DT_INT64_REFm
DT_BOOL_REFn
DT_QINT8_REFo
DT_QUINT8_REFp
DT_QINT32_REFq
DT_BFLOAT16_REFr
DT_QINT16_REFs
DT_QUINT16_REFt
DT_UINT16_REFu
DT_COMPLEX128_REFv
DT_HALF_REFw
DT_RESOURCE_REFx
DT_VARIANT_REFy
DT_UINT32_REFz
DT_UINT64_REF{Bk
org.tensorflow.frameworkBTypesProtosPZ=github.com/tensorflow/tensorflow/tensorflow/go/core/framework�J�
  B

  



 
	
 

 ,
	
 ,

 "
	

 "

 1
	
 1

 T
	
 T

 
 B LINT.IfChange



 

d
  W Not a legal value for DataType.  Used to indicate a DataType field
 has not been set.


  

  
^
 Q Data types that all computation devices are expected to be
 capable to support.


 


 

 

 

 

 

 


 

 

 


 

 

 


 

 

 	

 

 

 

 
'
 " Single-precision complex


 

 

 	

 	


 	

 


 
	

 


 " Quantized int8


 


 

 " Quantized uint8


 

 

 " Quantized int32


 

 
@
 "3 Float32 truncated to 16 bits.  Only for cast ops.


 

 

 " Quantized int16


 

 

  " Quantized uint16


  

  

 !

 !

 !
'
 "" Double-precision complex


 "

 "

 #

 #	

 #

 $

 $

 $
'
 %" Arbitrary C++ data types


 %

 %

 &

 &

 &

 '

 '

 '
�
 +� Do not use!  These are only for parameters.  Every enum above
 should have a corresponding value below (verified by types_test).


 +

 +

 ,

 ,

 ,

 -

 -

 -

 .

 .

 .

 /

 /

 /

 0

 0

 0

 1

 1

 1

 2

 2

 2

  3

  3

  3

 !4

 !4

 !4

 "5

 "5

 "5

 #6

 #6

 #6

 $7

 $7

 $7

 %8

 %8

 %8

 &9

 &9

 &9

 ':

 ':

 ':

 (;

 (;

 (;

 )<

 )<

 )<

 *=

 *=

 *=

 +>

 +>

 +>

 ,?

 ,?

 ,?

 -@

 -@

 -@

 .A

 .A

 .Abproto3
�&
&tensorflow/core/framework/tensor.proto
tensorflow/tensorflow/core/framework/resource_handle.proto,tensorflow/core/framework/tensor_shape.proto%tensorflow/core/framework/types.proto"�
TensorProto*
dtype (2.tensorflow.DataTypeRdtype?
tensor_shape (2.tensorflow.TensorShapeProtoRtensorShape%
version_number (RversionNumber%
tensor_content (RtensorContent
half_val (BRhalfVal
	float_val (BRfloatVal!

double_val (BR	doubleVal
int_val (BRintVal

string_val (R	stringVal%
scomplex_val	 (BRscomplexVal
	int64_val
 (BRint64Val
bool_val (BRboolVal%
dcomplex_val (BRdcomplexValO
resource_handle_val (2.tensorflow.ResourceHandleProtoRresourceHandleValC
variant_val (2".tensorflow.VariantTensorDataProtoR
variantVal!

uint32_val (BR	uint32Val!

uint64_val (BR	uint64Val"�
VariantTensorDataProto
	type_name (	RtypeName
metadata (Rmetadata1
tensors (2.tensorflow.TensorProtoRtensorsBl
org.tensorflow.frameworkBTensorProtosPZ=github.com/tensorflow/tensorflow/tensorflow/go/core/framework�J�
  ]

  



 
	
 

 -
	
 -

 "
	

 "

 1
	
 1

 T
	
 T
	
 8
	
	5
	

.
4
  S( Protocol buffer representing a tensor.



 

  

  

  


  

  
M
 $@ Shape of the tensor.  TODO(touts): sort out the 0-rank issues.


 

 

 

 "#
�
 � Version number.

 In version 0, if the "repeated xxx" representations contain only one
 element, that element is repeated to fill the shape.  This makes it easy
 to represent a constant Tensor with a single value.
2� Only one of the representations below is set, one of "tensor_contents" and
 the "xxx_val" attributes.  We are not using oneof because as oneofs cannot
 contain repeated fields it would require another extra set of messages.


 $

 

 

 
�
 #� Serialized raw tensor content from either Tensor::AsProtoTensorContent or
 memcpy in tensorflow::grpc::EncodeTensorToByteBuffer. This representation
 can be used for all tensor types. The purpose of this representation is to
 reduce serialization overhead during RPC call by avoiding serialization of
 many repeated small items.


 #

 #

 #

 #
�
 ,/� DT_HALF, DT_BFLOAT16. Note that since protobuf has no int16 type, we'll
 have some pointless zero padding for each value here.
2� Type specific representations that make it easy to create tensor protos in
 all languages.  Only the representation corresponding to "dtype" can
 be set.  The values hold the flattened representation of the tensor in
 row major order.


 ,


 ,

 ,

 ,

 ,.

 , -

 // DT_FLOAT.


 /


 /

 /

 /

 /.

 / -

 21 DT_DOUBLE.


 2


 2

 2

 2 

 2!0

 2"/
5
 5-( DT_INT32, DT_INT16, DT_INT8, DT_UINT8.


 5


 5

 5

 5

 5,

 5+

 8  DT_STRING


 8


 8

 8

 8
�
 	<2y DT_COMPLEX64. scomplex_val(2*i) and scomplex_val(2*i+1) are real
 and imaginary parts of i-th single precision complex.


 	<


 	<

 	<

 	< !

 	<"1

 	<#0

 
?0
 DT_INT64


 
?


 
?

 
?

 
?

 
? /

 
?!.

 B.	 DT_BOOL


 B


 B

 B

 B

 B-

 B,
�
 F4z DT_COMPLEX128. dcomplex_val(2*i) and dcomplex_val(2*i+1) are real
 and imaginary parts of i-th double precision complex.


 F


 F

 F

 F!#

 F$3

 F%2

 I8 DT_RESOURCE


 I


 I

 I2

 I57

 L3 DT_VARIANT


 L


 L!

 L"-

 L02

 O2 DT_UINT32


 O


 O

 O

 O!

 O"1

 O#0

 R2 DT_UINT64


 R


 R

 R

 R!

 R"1

 R#0
Z
V ]N Protocol buffer representing the serialization format of DT_VARIANT tensors.



V
<
 X/ Name of the type of objects being serialized.


 XV 

 X

 X	

 X
;
Z. Portions of the object that are not Tensors.


ZX

Z

Z

Z
A
\#4 Tensors contained within objects being serialized.


\


\

\

\!"bproto3
�
*tensorflow/core/framework/attr_value.proto
tensorflow&tensorflow/core/framework/tensor.proto,tensorflow/core/framework/tensor_shape.proto%tensorflow/core/framework/types.proto"�
	AttrValue
s (H Rs
i (H Ri
f (H Rf
b (H Rb*
type (2.tensorflow.DataTypeH Rtype4
shape (2.tensorflow.TensorShapeProtoH Rshape1
tensor (2.tensorflow.TensorProtoH Rtensor5
list (2.tensorflow.AttrValue.ListValueH Rlist.
func
 (2.tensorflow.NameAttrListH Rfunc"
placeholder	 (	H Rplaceholder�
	ListValue
s (Rs
i (BRi
f (BRf
b (BRb,
type (2.tensorflow.DataTypeBRtype2
shape (2.tensorflow.TensorShapeProtoRshape/
tensor (2.tensorflow.TensorProtoRtensor,
func	 (2.tensorflow.NameAttrListRfuncB
value"�
NameAttrList
name (	Rname6
attr (2".tensorflow.NameAttrList.AttrEntryRattrN
	AttrEntry
key (	Rkey+
value (2.tensorflow.AttrValueRvalue:8Bo
org.tensorflow.frameworkBAttrValueProtosPZ=github.com/tensorflow/tensorflow/tensorflow/go/core/framework�J�
  =

  



 
	
 

 0
	
 0

 "
	

 "

 1
	
 1

 T
	
 T
	
 /
	
	5
	

.
�
  6� Protocol buffer representing the value for an attr used to configure an Op.
 Comment indicates the corresponding attr type.  Only the field matching the
 attr type may be filled.



 

   LINT.IfChange


  


   " "list(string)"


   

   

   

   

  )" "list(int)"


  

  

  

  

  (

  '

  )" "list(float)"


  

  

  

  

  (

  '

  (" "list(bool)"


  

  

  

  

  '

  &

  /" "list(type)"


  

  

  

  

  .

   -

  (" "list(shape)"


  

  

  #

  &'

  $" "list(tensor)"


  

  

  

  "#

  #" "list(attr)"


  

  

  

  !"

  5

  

  "
 "string"


  	

  


  

 " "int"


 	

 


 

  "	 "float"


  	

  


  

 !" "bool"


 !

 !	


 !

 "" "type"


 "

 "

 "

 #"	 "shape"


 #

 #

 #

 $"
 "tensor"


 $

 $

 $

 %" any "list(...)"


 %

 %

 %
�
 +� "func" represents a function. func.name is a function's name or
 a primitive op's name. func.attr.first is the name of an attr
 defined for that function. func.attr.second is the value for
 that attr in the instantiation.


 +

 +

 +
�
 	4� This is a placeholder only used in nodes defined inside a
 function.  It indicates the attr value will be supplied when
 the function is instantiated.  For example, let us suppose a
 node "N" in function "FN". "N" has an attr "A" with value
 placeholder = "foo". When FN is instantiated with attr "foo"
 set to "bar", the instantiated node N's attr A will have been
 given the value "bar".


 	4


 	4

 	4
|
: =p A list of attr names and their values. The whole list is attached
 with a string name.  E.g., MatMul[T=float].



:

 ;

 ;:

 ;

 ;	

 ;

<"

<;

<

<

< !bproto3
�
(tensorflow/core/framework/node_def.proto
tensorflow*tensorflow/core/framework/attr_value.proto"�
NodeDef
name (	Rname
op (	Rop
input (	Rinput
device (	Rdevice1
attr (2.tensorflow.NodeDef.AttrEntryRattra
experimental_debug_info (2).tensorflow.NodeDef.ExperimentalDebugInfoRexperimentalDebugInfoN
	AttrEntry
key (	Rkey+
value (2.tensorflow.AttrValueRvalue:8G
ExperimentalDebugInfo.
original_node_names (	RoriginalNodeNamesBi
org.tensorflow.frameworkB	NodeProtoPZ=github.com/tensorflow/tensorflow/tensorflow/go/core/framework�J�
  L

  



 
	
 

 *
	
 *

 "
	

 "

 1
	
 1

 T
	
 T
	
 3


 
 L


 

�
  � The name given to this operator. Used for naming inputs,
 logging, visualization, etc.  Unique within a single GraphDef.
 Must match the regexp "[A-Za-z0-9.][A-Za-z0-9_./]*".


  


  

  	

  
�
 � The operation name.  There may be custom parameters in attrs.
 Op names starting with an underscore are reserved for internal use.


 

 

 	

 
�
 � Each input is "node:src_output" with "node" being a string name and
 "src_output" indicating which output tensor to use from "node". If
 "src_output" is 0 the ":0" suffix can be omitted.  Regular inputs
 may optionally be followed by control inputs that have the format
 "^node".


 


 

 

 
�
 /� A (possibly partial) specification for the device on which this
 node should be placed.
 The expected syntax for this string is as follows:

 DEVICE_SPEC ::= PARTIAL_SPEC

 PARTIAL_SPEC ::= ("/" CONSTRAINT) *
 CONSTRAINT ::= ("job:" JOB_NAME)
              | ("replica:" [1-9][0-9]*)
              | ("task:" [1-9][0-9]*)
              | ("device:" [A-Za-z]* ":" ([1-9][0-9]* | "*") )

 Valid values for this string include:
 * "/job:worker/replica:0/task:1/device:GPU:3"  (full specification)
 * "/job:worker/device:GPU:3"                   (partial specification)
 * ""                                    (no specification)

 If the constraints do not resolve to a single device (or if this
 field is empty or not present), the runtime will attempt to
 choose a device automatically.


 /

 /

 /	

 /
�
 ="� Operation-specific graph-construction-time configuration.
 Note that this should include all attrs defined in the
 corresponding OpDef, including those with a value matching
 the default -- this allows the default to change and makes
 NodeDefs easier to interpret on their own.  However, if
 an attr with a default is not specified in this list, the
 default will be used.
 The "names" (keys) must match the regexp "[a-z][a-z0-9_]+" (and
 one of the names from the corresponding OpDef's attr field).
 The values must have a type matching the corresponding OpDef
 attr's type field.
 TODO(josh11b): Add some examples here showing best practices.


 =/

 =

 =

 = !

 ?H

 ?

�
  G,� Opaque string inserted into error messages created by the runtime.

 This is intended to store the list of names of the nodes from the
 original graph that this node was derived. For example if this node, say
 C, was result of a fusion of 2 nodes A and B, then 'original_node' would
 be {A, B}. This information can be used to map errors originating at the
 current node to some top level source code.


  G

  G

  G'

  G*+
F
 K49 This stores debug information associated with the node.


 KH

 K

 K/

 K23bproto3
�D
&tensorflow/core/framework/op_def.proto
tensorflow*tensorflow/core/framework/attr_value.proto%tensorflow/core/framework/types.proto"�
OpDef
name (	Rname5
	input_arg (2.tensorflow.OpDef.ArgDefRinputArg7

output_arg (2.tensorflow.OpDef.ArgDefR	outputArg-
attr (2.tensorflow.OpDef.AttrDefRattr;
deprecation (2.tensorflow.OpDeprecationRdeprecation
summary (	Rsummary 
description (	Rdescription%
is_commutative (RisCommutative!
is_aggregate (RisAggregate
is_stateful (R
isStateful<
allows_uninitialized_input (RallowsUninitializedInput�
ArgDef
name (	Rname 
description (	Rdescription(
type (2.tensorflow.DataTypeRtype
	type_attr (	RtypeAttr
number_attr (	R
numberAttr$
type_list_attr (	RtypeListAttr
is_ref (RisRef�
AttrDef
name (	Rname
type (	Rtype:
default_value (2.tensorflow.AttrValueRdefaultValue 
description (	Rdescription
has_minimum (R
hasMinimum
minimum (Rminimum<
allowed_values (2.tensorflow.AttrValueRallowedValues"K
OpDeprecation
version (Rversion 
explanation (	Rexplanation"+
OpList!
op (2.tensorflow.OpDefRopBk
org.tensorflow.frameworkBOpDefProtosPZ=github.com/tensorflow/tensorflow/tensorflow/go/core/framework�J�9
  �

  



 
	
 

 ,
	
 ,

 "
	

 "

 1
	
 1

 T
	
 T
	
 3
	
	.
�
  �� Defines an operation. A NodeDef in a GraphDef specifies an Op by
 using the "op" field which should match the name of a OpDef.
 LINT.IfChange



 
�
  � Op names starting with an underscore are reserved for internal use.
 Names should be CamelCase and match the regexp "[A-Z][a-zA-Z0-9_]*".


  

  

  	

  
2
  0$ For describing inputs and outputs.


  

W
   H Name for the input/output.  Should match the regexp "[a-z][a-z0-9_]*".


   

   


   

   
,
   Human readable description.


  

  


  

  
�
  %� Describes the type of one or more tensors that are accepted/produced
 by this input/output arg.  The only legal combinations are:
 * For a single tensor: either the "type" field is set or the
   "type_attr" field is set to the name of an attr with type "type".
 * For a sequence of tensors with the same type: the "number_attr"
   field will be set to the name of an attr with type "int", and
   either the "type" or "type_attr" field will be set as for
   single tensors.
 * For a sequence of tensors, the "type_list_attr" field will be set
   to the name of an attr with type "list(type)".


  %

  %

  %

  %
9
  &"* if specified, attr must have type "type"


  &%

  &


  &

  &
8
  '") if specified, attr must have type "int"


  '&

  '


  '

  '
�
  *q If specified, attr must have type "list(type)", and none of
 type, type_attr, and number_attr may be specified.


  *'

  *


  *

  *
�
  /� For inputs: if true, the inputs are required to be refs.
   By default, inputs can be either refs or non-refs.
 For outputs: if true, outputs are refs, otherwise they are not.


  /*

  /

  /	

  /
+
 3  Description of the input(s).


 3


 3

 3

 3
,
 6! Description of the output(s).


 6


 6

 6

 6 
�
 ;^� Description of the graph-construction-time configuration of this
 Op.  That is to say, this describes the attr fields that will
 be specified in the NodeDef.


 ;

�
  ?� A descriptive name for the argument.  May be used, e.g. by the
 Python client, as a keyword argument name, and so should match
 the regexp "[a-z][a-z0-9_]+".


  ?;

  ?


  ?

  ?
f
 CW One of the type names from attr_value.proto ("string", "list(string)",
 "int", etc.).


 C?

 C


 C

 C
�
 G � A reasonable default for this attribute if the user does not supply
 a value.  If not specified, the user must supply a value.


 GC

 G

 G

 G
,
 J Human-readable description.


 JG 

 J


 J

 J
�
 Tb For type == "int", this is a minimum value.  For "list(___)"
 types, this is the minimum length.
2" TODO(josh11b): bool is_optional?
2f --- Constraints ---
 These constraints are only in effect if specified.  Default is no
 constraints.


 TJ

 T

 T	

 T

 U

 UT

 U	

 U


 U
�
 ]!� The set of allowed values.  Has type that is the "list" version
 of the "type" field above (uses the "list" field of AttrValue).
 If type == "type" or "list(type)" above, then the "type" field
 of "allowed_values.list" has the set of allowed DataTypes.
 If type == "string" or "list(string)", then the "s" field of
 "allowed_values.list" has the set of allowed strings.


 ]U

 ]

 ]

 ] 

 _

 _


 _

 _

 _
?
 b 2 Optional deprecation based on GraphDef versions.


 b_

 b

 b

 b
G
 e: One-line human-readable description of what the Op does.


 eb 

 e

 e	

 e
Q
 hD Additional, longer human-readable description of what the Op does.


 he

 h

 h	

 h
�
 nL True if the operation is commutative ("op(a,b) == op(b,a)" for all inputs)
2� -------------------------------------------------------------------------
 Which optimizations this operation can participate in.


 nh

 n

 n

 n
�
 x� If is_aggregate is true, then this operation accepts N >= 2
 inputs and produces 1 output all of the same type.  Should be
 associative and commutative, and produce output with the same
 shape as the input.  The optimizer may replace an aggregate op
 taking input from multiple devices with a tree of aggregate ops
 that aggregate locally within each device (and possibly within
 groups of nearby devices) before communicating.
 TODO(josh11b): Implement that optimization.
" for things like add


 xn

 x

 x

 x
�
 	�� Ops are marked as stateful if their behavior depends on some state beyond
 their input tensors (e.g. variable reading op) or if they have
 a side-effect (e.g. printing or asserting ops). Equivalently, stateless ops
 must always produce the same output for the same input and have
 no side-effects.

 By default Ops may be moved between devices.  Stateful ops should
 either not be moved, or should only be moved if that state can also
 be moved (e.g. via some sort of save / restore).
 Stateful ops are guaranteed to never be optimized away by Common
 Subexpression Elimination (CSE).
"" for things like variables, queue
2o Other optimizations go here, like
   can_alias_input, rewrite_when_output_unused, partitioning_strategy, etc.
2f -------------------------------------------------------------------------
 Optimization constraints.


 	�x

 	�

 	�

 	�
�
 
�'� By default, all inputs to an Op must be initialized Tensors.  Ops
 that may initialize tensors for the first time should set this
 field to true, to allow the Op to take an uninitialized Tensor as
 input.
" for Assign, etc.
2b -------------------------------------------------------------------------
 Non-standard options.


 
��

 
�

 
�!

 
�$&
H
� �: Information about version-dependent deprecation of an op


�
E
 �7 First GraphDef version at which the op is disallowed.


 ��

 �

 �

 �
M
�? Explanation of why it was deprecated and what to use instead.


��

�

�	

�
&
� � A collection of OpDefs


�

 �

 �


 �

 �

 �bproto3
�'
(tensorflow/core/framework/function.proto
tensorflow*tensorflow/core/framework/attr_value.proto(tensorflow/core/framework/node_def.proto&tensorflow/core/framework/op_def.proto"~
FunctionDefLibrary3
function (2.tensorflow.FunctionDefRfunction3
gradient (2.tensorflow.GradientDefRgradient"�
FunctionDef/
	signature (2.tensorflow.OpDefR	signature5
attr (2!.tensorflow.FunctionDef.AttrEntryRattr.
node_def (2.tensorflow.NodeDefRnodeDef2
ret (2 .tensorflow.FunctionDef.RetEntryRretN
	AttrEntry
key (	Rkey+
value (2.tensorflow.AttrValueRvalue:86
RetEntry
key (	Rkey
value (	Rvalue:8J"W
GradientDef#
function_name (	RfunctionName#
gradient_func (	RgradientFuncBn
org.tensorflow.frameworkBFunctionProtosPZ=github.com/tensorflow/tensorflow/tensorflow/go/core/framework�J� 
  e

  



 
	
 

 /
	
 /

 "
	

 "

 1
	
 1

 T
	
 T
	
 3
	
	1
	

/
4
  ( A library is a set of named functions.



 

  $

  


  

  

  "#

 $

 


 

 

 "#
�
 N� A function can be instantiated when the runtime can bind every attr
 with a value. When a GraphDef has a call to a function, it must
 have binding for every attr defined in the signature.

 TODO(zhifengc):
   * device spec, etc.




[
 N The definition of the function's name, arguments, return values,
 attrs etc.


 

 

 

 
?
"2 Attributes specific to this function definition.








 !
L
	!@ NOTE: field id 2 deleted on Jan 11, 2017, GraphDef version 21.


	 !

	 !

	 !
�
I � By convention, "op" in node_def is resolved by consulting with a
 user-defined library first. If not resolved, "func" is assumed to
 be a builtin op.
2� In both of the following fields, there is the need to specify an
 output that is used as either the input to another node (in
 `node_def`) or as a return value of the function (in `ret`).
 Unlike the NodeDefs in GraphDef, we need to be able to specify a
 list in some cases (instead of just single outputs).  Also, we
 need to be able to deal with lists of unknown length (so the
 output index may not be known at function definition time).  So
 we use the following format instead:
 * "fun_in" where "fun_in" is the name of a function input arg in
   the `signature` field above.  This represents that input, whether
   it is a single tensor or a list.
 * "fun_in:0" gives the first element of a function input arg (a
   non-list input is considered a list of length 1 for these
   purposes).
 * "node:out" where "node" is the name of a node in `node_def` and
   "out" is the name one of its op's output arguments (the name
   comes from the OpDef of the node's op). This represents that
   node's output, whether it is a single tensor or a list.
   Note: We enforce that an op's output arguments are never
   renamed in the backwards-compatibility test.
 * "node:out:0" gives the first element of a node output arg (a
   non-list output is considered a list of length 1 for these
   purposes).

 NOT CURRENTLY SUPPORTED (but may be in the future):
 * "node:out:-1" gives last element in a node output list
 * "node:out:1:" gives a list with all but the first element in a
   node output list
 * "node:out::-1" gives a list with all but the last element in a
   node output list
2� The body of the function.  Unlike the NodeDefs in a GraphDef, attrs
 may have values of type `placeholder` and the `input` field uses
 the "output" format above.


I


I

I

I
�
M A mapping from the output arg names from `signature` to the
 outputs from `node_def` that should be returned by the function.


MI 

M

M

M
�
b e� GradientDef defines the gradient function of a function defined in
 a function library.

 A gradient function g (specified by gradient_func) for a function f
 (specified by function_name) must follow the following:

 The function 'f' must be a numerical function which takes N inputs
 and produces M outputs. Its gradient function 'g', which is a
 function taking N + M inputs and produces N outputs.

 I.e. if we have
    (y1, y2, ..., y_M) = f(x1, x2, ..., x_N),
 then, g is
    (dL/dx1, dL/dx2, ..., dL/dx_N) = g(x1, x2, ..., x_N,
                                      dL/dy1, dL/dy2, ..., dL/dy_M),
 where L is a scalar-value function of (x1, x2, ..., xN) (e.g., the
 loss function). dL/dx_i is the partial derivative of L with respect
 to x_i.



b
!
 c" The function name.


 cb

 c

 c	

 c
,
d" The gradient function's name.


dc

d

d	

dbproto3
�	
(tensorflow/core/framework/versions.proto
tensorflow"p

VersionDef
producer (Rproducer!
min_consumer (RminConsumer#
bad_consumers (RbadConsumersBn
org.tensorflow.frameworkBVersionsProtosPZ=github.com/tensorflow/tensorflow/tensorflow/go/core/framework�J�
  

  



 
	
 

 /
	
 /

 "
	

 "

 1
	
 1

 T
	
 T
�
  � Version information for a piece of serialized data

 There are different types of versions for each type of data
 (GraphDef, etc.), but they all have the same common shape
 described here.

 Each consumer has "consumer" and "min_producer" versions (specified
 elsewhere).  A consumer is allowed to consume this data if

   producer >= min_producer
   consumer >= min_consumer
   consumer not in bad_consumers




 
?
  2 The version of the code that produced this data.


  

  

  

  
S
 F Any consumer below this version is not allowed to consume this data.


 

 

 

 
R
 #E Specific consumer versions which are disallowed (e.g. due to bugs).


 


 

 

 !"bproto3
�
%tensorflow/core/framework/graph.proto
tensorflow(tensorflow/core/framework/node_def.proto(tensorflow/core/framework/function.proto(tensorflow/core/framework/versions.proto"�
GraphDef'
node (2.tensorflow.NodeDefRnode2
versions (2.tensorflow.VersionDefRversions
version (BRversion8
library (2.tensorflow.FunctionDefLibraryRlibraryBk
org.tensorflow.frameworkBGraphProtosPZ=github.com/tensorflow/tensorflow/tensorflow/go/core/framework�J�
  7

  



 
	
 

 ,
	
 ,

 "
	

 "

 1
	
 1

 T
	
 T
	
 1
	
	1
	

1
0
  7$ Represents the graph of operations



 

  

  


  

  

  
�
 � Compatibility versions of the graph.  See core/public/version.h for version
 history.  The GraphDef version is distinct from the TensorFlow version, and
 each release of TensorFlow will support a range of GraphDef versions.


 

 

 

 
�
 (� Deprecated single version field; use versions above instead.  Since all
 GraphDef changes before "versions" was introduced were forward
 compatible, this field is entirely ignored.


 

 

 

 

 '

 &
�
 6!� EXPERIMENTAL. DO NOT USE OR DEPEND ON THIS YET.

 "library" provides user-defined functions.

 Naming:
   * library.function.name are in a flat namespace.
     NOTE: We may need to change it to be hierarchical to support
     different orgs. E.g.,
     { "/google/nn", { ... }},
     { "/google/vision", { ... }}
     { "/org_foo/module_bar", { ... }}
     map<string, FunctionDefLib> named_lib;
   * If node[i].op is the name of one function in "library",
     node[i] is deemed as a function call. Otherwise, node[i].op
     must be a primitive operation supported by the runtime.


 Function call semantics:

   * The callee may start execution as soon as some of its inputs
     are ready. The caller may want to use Tuple() mechanism to
     ensure all inputs are ready in the same time.

   * The consumer of return values may start executing as soon as
     the return values the consumer depends on are ready.  The
     consumer may want to use Tuple() mechanism to ensure the
     consumer does not start until all return values of the callee
     function are ready.


 6(

 6

 6

 6 bproto3
�
$tensorflow/core/protobuf/saver.proto
tensorflow"�
SaverDef0
filename_tensor_name (	RfilenameTensorName(
save_tensor_name (	RsaveTensorName&
restore_op_name (	RrestoreOpName
max_to_keep (R	maxToKeep
sharded (Rsharded@
keep_checkpoint_every_n_hours (RkeepCheckpointEveryNHoursF
version (2,.tensorflow.SaverDef.CheckpointFormatVersionRversion"5
CheckpointFormatVersion

LEGACY 
V1
V2Be
org.tensorflow.utilBSaverProtosPZ<github.com/tensorflow/tensorflow/tensorflow/go/core/protobuf�J�
  .

  



 
	
 

 ,
	
 ,

 "
	

 "

 ,
	
 ,

 S
	
 S
H
 
 .< Protocol buffer representing the configuration of a Saver.



 

t
  "g The name of the tensor in which to specify the filename when saving or
 restoring a model checkpoint.


  


  

  	

   !
C
 6 The operation to run when saving a model checkpoint.


 "

 

 	

 
F
 9 The operation to run when restoring a model checkpoint.


 

 

 	

 
X
 K Maximum number of checkpoints to keep.  If 0, no checkpoints are deleted.


 

 

 

 
L
 ? Shard the save files, one per device that has Variable nodes.


 

 

 

 
�
 *� How often to keep an additional checkpoint. If not specified, only the last
 "max_to_keep" checkpoints are kept; if specified, in addition to keeping
 the last "max_to_keep" checkpoints, an additional checkpoint will be kept
 for every n hours of training.


 

 

 %

 ()
�
  %,� A version number that identifies a different on-disk checkpoint format.
 Usually, each subclass of BaseSaverBuilder works with a particular
 version/format.  However, it is possible that the same builder may be
 upgraded to support a newer checkpoint format in the future.


  %
(
   ' Internal legacy format.


   '


   '
Y
  )J Deprecated format: tf.Saver() which works with tensorflow::table::Table.


  )

  )	

0
  +! Current format: more efficient.


  +

  +	


 -&

 -,

 -

 -!

 -$%bproto3
�n
)tensorflow/core/protobuf/meta_graph.proto
tensorflowgoogle/protobuf/any.proto%tensorflow/core/framework/graph.proto&tensorflow/core/framework/op_def.proto,tensorflow/core/framework/tensor_shape.proto%tensorflow/core/framework/types.proto$tensorflow/core/protobuf/saver.proto"�
MetaGraphDefH
meta_info_def (2$.tensorflow.MetaGraphDef.MetaInfoDefRmetaInfoDef1
	graph_def (2.tensorflow.GraphDefRgraphDef1
	saver_def (2.tensorflow.SaverDefRsaverDefR
collection_def (2+.tensorflow.MetaGraphDef.CollectionDefEntryRcollectionDefO
signature_def (2*.tensorflow.MetaGraphDef.SignatureDefEntryRsignatureDef>
asset_file_def (2.tensorflow.AssetFileDefRassetFileDef�
MetaInfoDef,
meta_graph_version (	RmetaGraphVersion<
stripped_op_list (2.tensorflow.OpListRstrippedOpList/
any_info (2.google.protobuf.AnyRanyInfo
tags (	Rtags-
tensorflow_version (	RtensorflowVersion4
tensorflow_git_version (	RtensorflowGitVersion4
stripped_default_attrs (RstrippedDefaultAttrs[
CollectionDefEntry
key (	Rkey/
value (2.tensorflow.CollectionDefRvalue:8Y
SignatureDefEntry
key (	Rkey.
value (2.tensorflow.SignatureDefRvalue:8"�
CollectionDefA
	node_list (2".tensorflow.CollectionDef.NodeListH RnodeListD

bytes_list (2#.tensorflow.CollectionDef.BytesListH R	bytesListD

int64_list (2#.tensorflow.CollectionDef.Int64ListH R	int64ListD

float_list (2#.tensorflow.CollectionDef.FloatListH R	floatList>
any_list (2!.tensorflow.CollectionDef.AnyListH RanyList 
NodeList
value (	Rvalue!
	BytesList
value (Rvalue%
	Int64List
value (BRvalue%
	FloatList
value (BRvalue5
AnyList*
value (2.google.protobuf.AnyRvalueB
kind"�

TensorInfo
name (	H RnameA

coo_sparse (2 .tensorflow.TensorInfo.CooSparseH R	cooSparse*
dtype (2.tensorflow.DataTypeRdtype?
tensor_shape (2.tensorflow.TensorShapeProtoRtensorShape�
	CooSparse,
values_tensor_name (	RvaluesTensorName.
indices_tensor_name (	RindicesTensorName5
dense_shape_tensor_name (	RdenseShapeTensorNameB

encoding"�
SignatureDef<
inputs (2$.tensorflow.SignatureDef.InputsEntryRinputs?
outputs (2%.tensorflow.SignatureDef.OutputsEntryRoutputs
method_name (	R
methodNameQ
InputsEntry
key (	Rkey,
value (2.tensorflow.TensorInfoRvalue:8R
OutputsEntry
key (	Rkey,
value (2.tensorflow.TensorInfoRvalue:8"c
AssetFileDef7
tensor_info (2.tensorflow.TensorInfoR
tensorInfo
filename (	RfilenameBn
org.tensorflow.frameworkBMetaGraphProtosPZ<github.com/tensorflow/tensorflow/tensorflow/go/core/protobuf�J�X
  �

  



 
	
 

 0
	
 0

 "
	

 "

 1
	
 1

 S
	
 S
	
 "
	

.
	
/
	
5
	
.
	
-
�
  V� NOTE: This protocol buffer is evolving, and will go through revisions in the
 coming months.

 Protocol buffer containing the following which are necessary to restart
 training, run inference. It can be used to serialize/de-serialize memory
 objects necessary for running computation in a graph when crossing the
 process boundary. It can be used for long term storage of graphs,
 cross-language execution of graphs, etc.
   MetaInfoDef
   GraphDef
   SaverDef
   CollectionDef
   TensorInfo
   SignatureDef



 
�
  !C� Meta information regarding the graph to be exported.  To be used by users
 of this protocol buffer to encode information regarding their meta graph.


  !

�
   $"w User specified Version string. Can be the name of the model and revision,
 steps this model has been trained to, etc.


   $!

   $


   $

   $ !
�
  ( | A copy of the OpDefs used by the producer of this graph_def.
 Descriptions and Ops not used in graph_def are stripped out.


  ($"

  (


  (

  (
w
  ,%h A serialized protobuf. Can be the time this meta graph is created, or
 modified, or name of the model.


  ,( 

  ,

  , 

  ,#$
�
  4� User supplied tag(s) on the meta_graph and included graph_def.

 MetaGraphDefs should be tagged with their capabilities or use-cases.
 Examples: "train", "serve", "gpu", "tpu", etc.
 These tags enable loaders to access the MetaGraph(s) appropriate for a
 specific use-case or runtime environment.


  4

  4

  4

  4
�
  9"� The __version__ string of the tensorflow build used to write this graph.
 This will be populated by the framework, which will overwrite any user
 supplied value.


  94

  9


  9

  9 !
�
  >&� The __git_version__ string of the tensorflow build used to write this
 graph. This will be populated by the framework, which will overwrite any
 user supplied value.


  >9"

  >


  >!

  >$%
t
  B$e A flag to denote whether default-valued attrs have been stripped from
 the nodes in this graph_def.


  B>&

  B

  B	

  B"#

  D 

  DC

  D

  D

  D

 G GraphDef.


 GD 

 G


 G

 G

 J SaverDef.


 JG

 J


 J

 J
o
 N0b collection_def: Map from collection name to collections.
 See CollectionDef section for details.


 NJ

 N

 N+

 N./
c
 R.V signature_def: Map from user supplied key for a signature to a single
 SignatureDef.


 RN0

 R

 R)

 R,-
@
 U+3 Asset file def to be used with the defined graph.


 U


 U

 U&

 U)*
�
� �� CollectionDef should cover most collections.
 To add a user-defined collection, do one of the following:
 1. For simple data types, such as string, int, float:
      tf.add_to_collection("your_collection_name", your_simple_value)
    strings will be stored as bytes_list.

 2. For Protobuf types, there are three ways to add them:
    1) tf.add_to_collection("your_collection_name",
         your_proto.SerializeToString())

       collection_def {
         key: "user_defined_bytes_collection"
         value {
           bytes_list {
             value: "queue_name: \"test_queue\"\n"
           }
         }
       }

  or

    2) tf.add_to_collection("your_collection_name", str(your_proto))

       collection_def {
         key: "user_defined_string_collection"
         value {
          bytes_list {
             value: "\n\ntest_queue"
           }
         }
       }

  or

    3) any_buf = any_pb2.Any()
       tf.add_to_collection("your_collection_name",
         any_buf.Pack(your_proto))

       collection_def {
         key: "user_defined_any_collection"
         value {
           any_list {
             value {
               type_url: "type.googleapis.com/tensorflow.QueueRunnerDef"
               value: "\n\ntest_queue"
             }
           }
         }
       }

 3. For Python objects, implement to_proto() and from_proto(), and register
    them in the following manner:
    ops.register_proto_function("your_collection_name",
                                proto_type,
                                to_proto=YourPythonObject.to_proto,
                                from_proto=YourPythonObject.from_proto)
    These functions will be invoked to serialize and de-serialize the
    collection. For example,
    ops.register_proto_function(ops.GraphKeys.GLOBAL_VARIABLES,
                                proto_type=variable_pb2.VariableDef,
                                to_proto=Variable.to_proto,
                                from_proto=Variable.from_proto)


�
�
 ��� NodeList is used for collecting nodes in graph. For example
 collection_def {
   key: "summaries"
   value {
     node_list {
       value: "input_producer/ScalarSummary:0"
       value: "shuffle_batch/ScalarSummary:0"
       value: "ImageSummary:0"
     }
   }


 �


  �

  �

  �

  �

  �
�
��� BytesList is used for collecting strings and serialized protobufs. For
 example:
 collection_def {
   key: "trainable_variables"
   value {
     bytes_list {
       value: "\n\017conv1/weights:0\022\024conv1/weights/Assign
              \032\024conv1/weights/read:0"
       value: "\n\016conv1/biases:0\022\023conv1/biases/Assign\032
              \023conv1/biases/read:0"
     }
   }
 }


�


 �

 �

 �

 �

 �
N
��> Int64List is used for collecting int, int64 and long values.


�


 �-

 �

 �

 �

 �

 �,

 �+
@
��0 FloatList is used for collecting float values.


�


 �-

 �

 �

 �

 �

 �,

 �+
<
��, AnyList is used for collecting Any protos.


�


 �+

 �

 � 

 �!&

 �)*

 ��

 �

 �

 �

 �

 �

�

�

�

�

�

�

�

�

�

�

�

�

�

�

�

�
N
� �@ Information about a Tensor necessary for feeding or retrieval.


�
f
 ��V For sparse tensors, The COO encoding stores a triple of values, indices,
 and shape.


 �

�
  �"� The shape of the values Tensor is [?].  Its dtype must be the dtype of
 the SparseTensor as a whole, given in the enclosing TensorInfo.


  ��

  �


  �

  � !
L
 �#< The indices Tensor must have dtype int64 and shape [?, ?].


 ��"

 �


 �

 �!"
�
 �'� The dynamic logical shape represented by the SparseTensor is recorded in
 the Tensor referenced here.  It must have dtype int64 and shape [?].


 ��#

 �


 �"

 �%&

 ��

 �
I
 �; For dense `Tensor`s, the name of the tensor in the graph.


 �


 �

 �
�
�� There are many possible encodings of sparse matrices
 (https://en.wikipedia.org/wiki/Sparse_matrix).  Currently, TensorFlow
 uses only the COO encoding.  This is supported and documented in the
 SparseTensor Python class.


�

�

�

�

��

�


�

�
�
�$� The static shape should be recorded here, to the extent that it can
 be known in advance.  In the case of a SparseTensor, this field describes
 the logical shape of the represented tensor (aka dense_shape).


��

�

�

�"#
�

� ��
 SignatureDef defines the signature of a computation supported by a TensorFlow
 graph.

 For example, a model with two loss computations, sharing a single input,
 might have the following signature_def map.

 Note that across the two SignatureDefs "loss_A" and "loss_B", the input key,
 output key, and method_name are identical, and will be used by system(s) that
 implement or rely upon this particular loss method. The output tensor names
 differ, demonstrating how different outputs can exist for the same method.

 signature_def {
   key: "loss_A"
   value {
     inputs {
       key: "input"
       value {
         name: "input:0"
         dtype: DT_STRING
         tensor_shape: ...
       }
     }
     outputs {
       key: "loss_output"
       value {
         name: "loss_output_A:0"
         dtype: DT_FLOAT
         tensor_shape: ...
       }
     }
   }
   ...
   method_name: "some/package/compute_loss"
 }
 signature_def {
   key: "loss_B"
   value {
     inputs {
       key: "input"
       value {
         name: "input:0"
         dtype: DT_STRING
         tensor_shape: ...
       }
     }
     outputs {
       key: "loss_output"
       value {
         name: "loss_output_B:0"
         dtype: DT_FLOAT
         tensor_shape: ...
       }
     }
   }
   ...
   method_name: "some/package/compute_loss"
 }


�
'
 �% Named input parameters.


 ��

 �

 � 

 �#$
(
�& Named output parameters.


��%

�

�!

�$%
�
�� Extensible method_name information enabling third-party users to mark a
 SignatureDef as supporting a particular method. This enables producers and
 consumers of SignatureDefs, e.g. a model definition library and a serving
 library to have a clear hand-off regarding the semantics of a computation.

 Note that multiple SignatureDefs in a single MetaGraphDef may have the same
 method_name. This is commonly used to support multi-headed computation,
 where a single graph computation may return multiple results.


��&

�

�	

�
b
� �T An asset file def for a single file or a set of sharded files with the same
 name.


�
9
 �+ The tensor to bind the asset filename to.


 ��

 �

 �

 �
�
�� The filename within an assets directory. Note: does not include the path
 prefix, i.e. directories. For an asset at /tmp/path/vocab.txt, the filename
 would be "vocab.txt".


��

�

�	

�bproto3
�
0tensorflow_serving/apis/get_model_metadata.prototensorflow.servinggoogle/protobuf/any.proto)tensorflow/core/protobuf/meta_graph.proto#tensorflow_serving/apis/model.proto"�
SignatureDefMapZ
signature_def (25.tensorflow.serving.SignatureDefMap.SignatureDefEntryRsignatureDefY
SignatureDefEntry
key (	Rkey.
value (2.tensorflow.SignatureDefRvalue:8"~
GetModelMetadataRequest<

model_spec (2.tensorflow.serving.ModelSpecR	modelSpec%
metadata_field (	RmetadataField"�
GetModelMetadataResponse<

model_spec (2.tensorflow.serving.ModelSpecR	modelSpecV
metadata (2:.tensorflow.serving.GetModelMetadataResponse.MetadataEntryRmetadataQ
MetadataEntry
key (	Rkey*
value (2.google.protobuf.AnyRvalue:8B�J�
  

  



 
	
 
	
 "
	
2
	
,
9
 
 - Message returned for "signature_def" field.



 


  .

  


  

  )

  ,-


 



�
 � Model Specification indicating which model we are querying for metadata.
 If version is not specified, will use the latest (numerical) version.


 !

 

 

 
L
%? Metadata fields to get. Currently supported: "signature_def".







 

#$


 


 
S
 F Model Specification indicating which model this metadata belongs to.


 "

 

 

 
�
0� Map of metadata field name to metadata field. The options for metadata
 field name are listed in GetModelMetadataRequest. Currently supported:
 "signature_def".




"

#+

./bproto3
�
(tensorflow_serving/apis/regression.prototensorflow.serving#tensorflow_serving/apis/input.proto#tensorflow_serving/apis/model.proto""

Regression
value (Rvalue"T
RegressionResult@
regressions (2.tensorflow.serving.RegressionRregressions"�
RegressionRequest<

model_spec (2.tensorflow.serving.ModelSpecR	modelSpec/
input (2.tensorflow.serving.InputRinput"�
RegressionResponse<

model_spec (2.tensorflow.serving.ModelSpecR	modelSpec<
result (2$.tensorflow.serving.RegressionResultRresultB�J�
  $

  

 
	
 
	
 ,
	
,


G
 
 ; Regression result for a single item (tensorflow.Example).



 


  

  


  

  

  
j
 ^ Contains one result per input example, in the same order as the input in
 RegressionRequest.





 &

 


 

 !

 $%

 2 RPC interfaces.




j
 ] Model Specification. If version is not specified, will use the latest
 (numerical) version.


 

 

 

 

% Input data.






 

#$


 $



A
 !4 Effective Model Specification used for regression.


 !

 !

 !

 !

#

#!

#

#

#bproto3
�
'tensorflow_serving/apis/inference.prototensorflow.serving,tensorflow_serving/apis/classification.proto#tensorflow_serving/apis/input.proto#tensorflow_serving/apis/model.proto(tensorflow_serving/apis/regression.proto"n
InferenceTask<

model_spec (2.tensorflow.serving.ModelSpecR	modelSpec
method_name (	R
methodName"�
InferenceResult<

model_spec (2.tensorflow.serving.ModelSpecR	modelSpec_
classification_result (2(.tensorflow.serving.ClassificationResultH RclassificationResultS
regression_result (2$.tensorflow.serving.RegressionResultH RregressionResultB
result"�
MultiInferenceRequest7
tasks (2!.tensorflow.serving.InferenceTaskRtasks/
input (2.tensorflow.serving.InputRinput"W
MultiInferenceResponse=
results (2#.tensorflow.serving.InferenceResultRresultsB�J�

 :
�

 2� This file contains messages for various machine learning inferences
 such as regression and classification.

 In many applications more than one type of inference is desired for a single
 input.  For example, given meteorologic data an application may want to
 perform a classification to determine if we should expect rain, snow or sun
 and also perform a regression to predict the temperature.
 Sharing the single input data between two inference tasks can be accomplished
 using MultiInferenceRequest and MultiInferenceResponse.


 
	
 
	
 5
	
,
	
,
	
1


J
   > Inference request such as classification, regression, etc...



 
�
  � Model Specification. If version is not specified, will use the latest
 (numerical) version.
 All ModelSpecs in a MultiInferenceRequest must access the same model name.


  

  

  

  
�
 � Signature's method_name. Should be one of the method names defined in
 third_party/tensorflow/python/saved_model/signature_constants.py.
 e.g. "tensorflow/serving/classify".


 

 

 	

 
K
# *? Inference result, matches the type of request or is an error.



#

 $

 $#

 $

 $

 $

 &)

 &

'3

'

'.

'12

(+

(

(&

()*
@
- 34 Inference request containing one or more requests.



-

 /# Inference tasks.


 /


 /

 /

 /!"

2 Input data.


2/#

2

2

2
A
6 :5 Inference request containing one or more responses.



6
v
 9'i List of results; one for each InferenceTask in the request, returned in the
 same order as the request.


 9


 9

 9"

 9%&bproto3
�
%tensorflow_serving/apis/predict.prototensorflow.serving&tensorflow/core/framework/tensor.proto#tensorflow_serving/apis/model.proto"�
PredictRequest<

model_spec (2.tensorflow.serving.ModelSpecR	modelSpecF
inputs (2..tensorflow.serving.PredictRequest.InputsEntryRinputs#
output_filter (	RoutputFilterR
InputsEntry
key (	Rkey-
value (2.tensorflow.TensorProtoRvalue:8"�
PredictResponse<

model_spec (2.tensorflow.serving.ModelSpecR	modelSpecJ
outputs (20.tensorflow.serving.PredictResponse.OutputsEntryRoutputsS
OutputsEntry
key (	Rkey-
value (2.tensorflow.TensorProtoRvalue:8B�J�
  '

  



 
	
 
	
 /
	
,
�
  � PredictRequest specifies which TensorFlow model to run, as well as
 how inputs are mapped to tensors and how outputs are filtered before
 returning to user.



 
j
  ] Model Specification. If version is not specified, will use the latest
 (numerical) version.


  

  

  

  
�
 &� Input tensors.
 Names of input tensor are alias names. The mapping from aliases to real
 input tensor names is stored in the SavedModel export as a prediction
 SignatureDef under the 'inputs' field.


 

 

 !

 $%
�
 $� Output filter.
 Names specified are alias names. The mapping from aliases to real output
 tensor names is stored in the SavedModel export as a prediction
 SignatureDef under the 'outputs' field.
 Only tensors specified here will be run/fetched and returned, with the
 exception that when none is specified, all tensors specified in the
 named signature will be run/fetched and returned.


 


 

 

 "#
<
! '0 Response for PredictRequest on successful run.



!
L
 #? Effective Model Specification used to process PredictRequest.


 #!

 #

 #

 #

&' Output tensors.


&#

&

&"

&%&bproto3
�
0tensorflow_serving/apis/prediction_service.prototensorflow.serving,tensorflow_serving/apis/classification.proto0tensorflow_serving/apis/get_model_metadata.proto'tensorflow_serving/apis/inference.proto%tensorflow_serving/apis/predict.proto(tensorflow_serving/apis/regression.proto2�
PredictionServicea
Classify).tensorflow.serving.ClassificationRequest*.tensorflow.serving.ClassificationResponseX
Regress%.tensorflow.serving.RegressionRequest&.tensorflow.serving.RegressionResponseR
Predict".tensorflow.serving.PredictRequest#.tensorflow.serving.PredictResponseg
MultiInference).tensorflow.serving.MultiInferenceRequest*.tensorflow.serving.MultiInferenceResponsem
GetModelMetadata+.tensorflow.serving.GetModelMetadataRequest,.tensorflow.serving.GetModelMetadataResponseB�J�
  

  



 
	
 
	
 5
	
9
	
0
	
.
	
	1
�
  z open source marker; do not remove
 PredictionService provides access to machine-learned models loaded by
 model_servers.



 

  G Classify.


  

  $

  /E

 >
 Regress.


 

 

 *<
E
 88 Predict -- provides access to loaded TensorFlow model.


 

 

 '6
:
 M- MultiInference API for multi-headed models.


 

 *

 5K
Q
 )C GetModelMetadata - provides access to metadata for loaded models.


 

 .

 'bproto3