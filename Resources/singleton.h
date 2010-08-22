//
//  singleton.h
//  GKKit
//
//  Created by Gaurav Khanna on 7/17/10.
//
//  Permission is hereby granted, free of charge, to any person 
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without restriction,
//  including without limitation the rights to use, copy, modify, 
//  merge, publish, distribute, sublicense, and/or sell copies of 
//  the Software, and to permit persons to whom the Software is 
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be 
//  included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR 
//  ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF 
//  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#define MAKE_SINGLETON(class_name, shared_method_name) \
+ (id)shared_method_name { \
    static dispatch_once_t pred; \
    static class_name * z ## class_name ## _ = nil; \
    dispatch_once(&pred, ^{ \
        z ## class_name ## _ = [[self alloc] init]; \
    }); \
    return z ## class_name ## _; \
} \
- (id)copy { \
	return self; \
} \
- (id)retain { \
	return self; \
} \
- (NSUInteger)retainCount { \
	return UINT_MAX; \
} \
- (void)release { \
} \
- (id)autorelease { \
	return self; \
}
