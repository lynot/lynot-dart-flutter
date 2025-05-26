## 0.15.2

## 0.15.1

 - **FIX**(ly-form): change submit transform event to droppable.

## 0.15.0

 - **FIX**(ly-form): change submit transform event to droppable.

## 0.14.0

 - **PERF**(lyform): validate only the drity inputs.
 - **PERF**(lyform): change validator property to nullable.
 - **FIX**(lyform): call validatior in `isValid` getter.
 - **FIX**(lyform): validation when the form is pure.
 - **FIX**(lyform): type error in js compiler.
 - **FIX**(lyform): input is valid when is pure or validator run successfully.
 - **FIX**(lyform): input is valid when is pure or validator run successfully.

## 0.13.0+1

 - **PERF**: validate only the drity inputs.
 - **PERF**: change validator property to nullable.
 - **FIX**: type error in js compiler.
 - **FIX**: input is valid when is pure or validator run successfully.
 - **FIX**: input is valid when is pure or validator run successfully.

## 0.13.0

 - **FIX**: type error in js compiler.
 - **FIX**: input is valid when is pure or validator run successfully.

## 0.12.0

 - **FIX**: apply dirty instead of pure over inputs in reset event handler.

## 0.11.1

 - **FIX**: error in methods for return states quickly.

## 0.11.0

 - **FEAT**: improve equality of input and form states and make input a bloc.

## 0.10.1

 - **FIX**: remove equality check of lyform states.

## 0.10.0

 - **FIX**: include inputs in lyform states for add to equality checks.

## 0.9.2

 - **FEAT**: override `hashCode` and `==` in `LyFormState`.

## 0.9.1

 - **FEAT**: make form an iterable of inputs.

## 0.9.0

 - **FIX**: validation when is pure value.
 - **FEAT**: allow add and remove inputs.

## 0.8.0

 - Bump "lyform" to `0.8.0`.

## 0.7.6+1

 - **FIX**: rename input cubit to input bloc meanwhile.

## 0.7.6

 - Bump "lyform" to `0.7.6`.

## 0.7.5

 - **FEAT**: add onInit method to override behavior on started event.

## 0.7.4+2

 - **FIX**: add started event to form bloc.

## 0.7.4+1

 - **FIX**: change implementation of input dirty.

## 0.7.4

 - **FEAT**: implement input base and input cubit.

## 0.7.3

 - **REFACTOR**: improvement implementation of input bloc.

## 0.7.2

 - **FIX**: not changing when input is of type bool

## 0.7.1

 - **FIX**: melos config and migrate to dart 2.17.1.
 - **FIX**: emit pure state.
 - **FIX**: onLoading is not executed #11.
 - **DOCS**: update packages/lyform/README.md [skip ci].
 - **DOCS**: update packages/lyform/README.md [skip ci].

## 0.7.0

> Note: This release has breaking changes.

 - **FIX**: errors by previous merge.
 - **FIX**: execute the `onLoading` method.
 - **FIX**: close all `inputs` subscriptions.
 - **FEAT**: improve debug.
 - **FEAT**: add last not null property.
 - **BREAKING** **FEAT**: make on submit a stream.

## 0.6.1

 - **FEAT**: update bloc to version 8.
 - **CHORE**: publish packages.

## 0.6.0

> Note: This release has breaking changes.

 - **CHORE**: publish packages.
 - **BREAKING** **FEAT**: remove functional validators.

## 0.5.0

> Note: This release has breaking changes.

 - **BREAKING** **FEAT**: remove functional validators.

## 0.4.0

> Note: This release has breaking changes.

 - **BREAKING** **FEAT**: implement class base validator logic operations.

## 0.3.3

 - **FEAT**: implement "and" and "or" validators.
 - **FEAT**: expose DirectValueEvent.

## 0.3.2

 - **FEAT**: add toString methods to events and states.

## 0.3.1+3

 - **FIX**: add intermediate event on submit.

## 0.3.1+2

 - **FIX**: login of direct value event.

## 0.3.1+1

 - **FIX**: equals operator in InputBlocState<T>.
 - **DOCS**: update packages/lyform/README.md [skip ci].
 - **CHORE**: update readmes.

## 0.3.1

 - **FEAT**: add sponsor MeSirve.
 - **CHORE**: fix pubspecs and readmes.

## 0.3.0

> Note: This release has breaking changes.

 - **FIX**: validation on pure inputs.
 - **FEAT**: implement DirectValueEvent.
 - **FEAT**: add reset event to form bloc.
 - **FEAT**: Set inputs pure when on success submit.
 - **CHORE**: update dependencies.
 - **CHORE**: publish packages.
 - **CHORE**: publish packages.
 - **CHORE**: publish packages.
 - **CHORE**: publish packages.
 - **BREAKING** **FIX**: correct behavior of optional inputs.

## 0.2.1

 - **FEAT**: add reset event to form bloc.

## 0.2.0+1

 - **FIX**: validation on pure inputs.

## 0.2.0

> Note: This release has breaking changes.

 - **BREAKING** **FIX**: correct behavior of optional inputs.

## 0.1.4

 - **FEAT**: Set inputs pure when on success submit.
 - **FEAT**: migrate to bloc 7.2 and new on<Event> API.
 - **CHORE**: publish packages.
 - **CHORE**: add contributors to packages.
 - **CHORE**: improve readmes.
 - **CHORE**: add linter rules and other things for improve the monorepo system.

## 0.1.3

 - **FEAT**: migrate to bloc 7.2 and new on<Event> API.

## 0.1.2+2

 - **FIX**: fix validation on submit.

## 0.1.2+1

 - **FIX**: optional fields cant be pure.

## 0.1.2

 - **FEAT**: add optional value input.

## 0.1.1

 - **FEAT**: optional validation.

## 0.1.0+2

 - **FIX**: simplify input errors to String.

## 0.1.0+1

 - **FIX**: change FormBloc.isValid condition excluding pure InputBlocs.

## 0.1.0

> Note: This release has breaking changes.

 - **BREAKING** **FIX**: Change from InputError to Generic type.

## 0.0.1+1

 - **FIX**: homepage and repository links.
