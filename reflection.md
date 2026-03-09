# Reflection - Dart Fundamentals Assignment
## Conceptual Questions - Task 1

Q1. What is the difference between a List<int> and a List<dynamic> in Dart?
Why is it usually better to use a typed list like List<int>?

Answer:
A List<int> is a list that can only hold whole numbers. If you try to put
a word or a decimal number into it, Dart will immediately show you an error
before the program even runs. A List<dynamic> on the other hand accepts
anything — numbers, words, true/false values, or even objects — all mixed
together in the same list. At first I thought List<dynamic> sounded more
useful because it is flexible, but I learned that this flexibility is
actually a problem. When your list can hold anything, Dart cannot warn you
when you put the wrong type in by accident. The mistake only shows up when
the program is already running, which is much harder to fix. List<int> is
safer because mistakes are caught early, the code is easier to read, and
anyone looking at it immediately knows what kind of data to expect.

Q2. In your findMax() function, why is it important to initialize your
'running maximum' variable to the first element of the list rather than
to 0 or to a very small number? What could go wrong with the other approaches?

Answer:
When I first thought about this I also assumed starting at 0 would work.
But then I realized the problem — what if every number in the list is
negative? For example the list [-10, -3, -7] has no number bigger than 0.
If I start max at 0, the loop compares each negative number against 0, none
of them wins, and the function returns 0 — a number that was never even in
the list. That is a wrong answer. Starting with a very small number like
-9999 has the same risk if the list contains something even smaller.
The only safe choice is to start with numbers[0] because that is a real
value that actually exists in the list. Every other number gets compared
to it fairly and the correct maximum is always found.

Q3. Your calculateAverage() function calls calculateSum() internally.
What software design principle does this demonstrate, and why is reusing
existing functions preferable to duplicating code?

Answer:
This demonstrates the DRY principle which means Do not Repeat Yourself.
Instead of writing the addition loop a second time inside calculateAverage(),
I simply called calculateSum() which already does that work. The benefit
became clear to me when I thought about fixing bugs. If there is a mistake
in how the sum is calculated, I only need to fix it in one place and
calculateAverage() automatically gets the fix too. If I had copied the code,
I would need to remember to fix it in two places. In a large real program
with hundreds of functions, forgetting to update one copy could cause serious
problems that are very hard to find.

Q4. Describe in plain English what the for-in loop syntax does in Dart.
How is it different from a traditional for loop with an index? When would
you prefer one over the other?

Answer:
A for-in loop is like telling the program "go through this list and hand me
each item one at a time." You do not need to count or use an index — Dart
handles that automatically. For example "for (int n in numbers)" means give
me each number from the list and call it n so I can use it. A traditional
for loop uses a counter variable like i and you access elements by writing
numbers[i]. The for-in loop is simpler and cleaner when you only care about
the values themselves. The traditional for loop is better when you need to
know the position, for example if you want to compare an element with the
one next to it or skip certain positions.

Q5. If someone calls your findMax() function with an empty list, what happens?
How could you modify the function to handle that case safely?

Answer:
If findMax() receives an empty list, the program will crash immediately with
a RangeError because numbers[0] does not exist when there are no elements.
I actually did not think about this edge case until reading this question.
To fix it safely, I would add a check at the very beginning of the function.
If numbers.isEmpty is true, the function should print a clear message like
"Error: cannot find maximum of an empty list" and return a default value
like 0 so the rest of the program can continue running without crashing.
This kind of defensive programming is an important habit to build.

---

## Conceptual Questions - Task 2

Q6. What is the difference between a synchronous function and an asynchronous
function in Dart? In your Calculator class, why is divide() synchronous
while computeAsync() is asynchronous?

Answer:
A synchronous function runs from start to finish without stopping and the
program waits for it to complete before moving to the next line. An
asynchronous function can pause at certain points using await and let other
things happen while it is waiting. Think of it like ordering food at a
restaurant. A synchronous approach would mean standing at the counter and
doing nothing until your food is ready. An asynchronous approach means you
sit down, do other things, and the waiter brings the food when it is ready.
In our Calculator class, divide() is synchronous because dividing two numbers
is instant — there is nothing to wait for. computeAsync() is asynchronous
because it simulates a real-world delay like waiting for a server to respond,
and during that wait the program should remain free to do other things.

Q7. Explain the purpose of the await keyword in Dart. What happens if you
forget to use await when calling an async function that returns a Future?
What does your program print instead of the result?

Answer:
The await keyword tells Dart to pause the current function and wait until
the Future resolves into a real value before continuing. Without await, the
program does not wait at all. It just grabs the Future object itself — which
is like grabbing the order ticket instead of the actual food — and tries to
use it immediately. Instead of printing the number you expected, the program
prints something like "Instance of Future<double>" which is completely
useless output. I actually tested this while doing the assignment by removing
await from one of the calls in main() and I saw exactly this confusing output.
That experiment helped me understand why await is so important.

Q8. What is the purpose of the try-catch block in your displayResult() method?
What would happen if you removed it and then called displayResult(10, 0, 'divide')?

Answer:
The try-catch block acts like a safety net. The code inside the try section
runs normally, but if anything goes wrong and an error is thrown, the catch
section intercepts it before it can crash the program. Instead of crashing,
it prints a friendly message that the user can understand. If I removed the
try-catch and called displayResult(10, 0, 'divide'), the ArgumentError thrown
by divide() would have nowhere to go. The entire program would stop running
immediately and print a confusing technical error message. All the
calculations after that line would never run. The try-catch makes sure one
bad input does not destroy the whole program.

Q9. Why is it good design to have divide() throw an ArgumentError rather than
simply returning 0 or printing an error inside the divide() method itself?
What principle of function design does this reflect?

Answer:
At first returning 0 seemed like the simpler solution to me. But then I
realized the serious problem — 0 is a valid number that could appear in
real calculations. If divide() silently returns 0 when given a zero divisor,
the caller has no way to know whether the answer is genuinely 0 or whether
something went wrong. Throwing an ArgumentError is honest — it clearly
announces that something is wrong and forces the caller to deal with it.
Printing the error inside divide() would mix two different responsibilities
into one function: doing math and displaying messages. This violates the
Single Responsibility Principle which says each function should do only
one thing. The divide() function should only divide. How the error is
displayed is the caller's responsibility.

Q10. What does the async keyword on main() allow you to do? Could this
assignment have been written without making main() async? Explain your answer.

Answer:
The async keyword on main() allows us to use await inside the main function.
Without it Dart would not permit any await calls inside main() and the code
would not compile. Technically the assignment could be rewritten without
async on main() by chaining .then() callbacks instead of using await. But
.then() chains become very hard to read when you have multiple async calls
one after another. The async/await syntax was specifically designed to solve
this problem by making asynchronous code look as clean and readable as
regular synchronous code. Using async on main() is the correct modern
approach in Dart and I would always prefer it over .then() chains.

---

## Reflection Questions

## QR1. Which concept was hardest to understand?

Out of everything in this assignment, async/await was by far the hardest
concept for me to understand. Lists and loops made sense immediately because
I could trace through them line by line in my head. Classes felt natural
once I thought of them as a way to bundle related things together. Exception
handling was logical — things can go wrong and you prepare for that.

But async programming felt completely different. The idea that a function
could pause in the middle and let other code run while it was waiting did
not match how I had been thinking about programs. My mental model was that
code runs one line at a time from top to bottom. Futures broke that model.

The specific moment of confusion was when I first saw Future<double> as a
return type. I kept thinking "why not just return double?" I did not
understand why we needed this wrapper. The confusion cleared when I did the
experiment of removing await from a call in main() and saw
"Instance of Future<double>" printed on screen. That output made it
suddenly real to me — without await I was getting the container, not the
value inside it. Await opens the container and gives you what is inside.
After that experiment everything clicked into place.

## QR2. What would change if I used List<double> instead of List<int>?

Looking at my Task 1 solution, I counted about 7 to 8 places that would
need to change. The parameter type in all four functions would change from
List<int> to List<double>. The return types of findMax(), findMin(), and
calculateSum() would change from int to double. The variable declarations
in main() where I store max, min, and sum would also need updating.

What this tells me is that a type decision made at the beginning of a
project ripples through the entire codebase. In a small program like this
one, 7 to 8 changes is manageable. But imagine a professional app like
YouTube or TikTok with thousands of functions — changing a core data type
could require hundreds of changes and introduce new bugs in places you
never expected. This is why experienced developers think carefully about
data types before writing their first line of code, not after.

## QR3. A real Flutter async example from daily life

Every time I open YouTube on my phone and tap on a video, the app needs
to fetch that video's data from Google's servers. The title, thumbnail,
view count, description, and the video stream itself all come from a remote
server somewhere in the world. None of that data exists on my phone — the
app has to request it and wait for the response.

In Flutter, this would be an async operation. The Future would resolve to
a Video object containing all the details about that video. While my phone
is waiting for the server to respond — which could take one second or several
depending on my internet speed — the app shows a loading spinner or a
skeleton placeholder where the content will appear. This is async programming
working in real life. Without it, the entire YouTube app would freeze every
time you tapped a video and you could not scroll or do anything while waiting.
That would make the app completely unusable.

## QR4. Single function vs separate methods — my view

When I first read the assignment I actually wondered the same thing —
why write four separate functions when computeAsync() already handles all
operations with a single string parameter? It seemed like extra work.

But after completing the assignment I understand the reason. Having separate
methods like add(), subtract(), multiply(), and divide() means each one can
be read, understood, and tested completely on its own. If my multiply()
function gives a wrong answer, I know exactly where to look. I do not have
to dig through a large combined function trying to figure out which part
is broken.

The single function approach — like computeAsync() — is better when the
operation needs to be chosen dynamically, for example when a user types
a command or picks from a dropdown menu in an app. You cannot hardcode
which method to call in that situation.

The best solution, which I think our assignment demonstrates well, is to
use both together. Separate methods handle the actual logic cleanly and
the dispatcher function routes to the right one based on input. This gives
you the best of both approaches and is a pattern I expect to use many times
in real Flutter development.
