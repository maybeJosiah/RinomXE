/*
7/22/2025, 7:37PM, like done untested. X E.
*/
/*
5/7/2025, 10:24AM, start Slang shader. X E.
11:21AM, like done, begin tests. X E.
5/8/2025, 12:26PM, errors, begin fixes.
12:27PM, done. X E.
12:51PM, like done and tested. X E.
5/9/2025, 12:54PM, begin fixes. X E.
1:03PM, like done. X E.
1:08PM, untested like done. X E.
5/13/2025, 4:26PM, like done. X E.
5/22/2025, 6:21PM, start work. X E.
6:21PM, done. X E.
6/4/2025, 6:30PM, done. X E.
7/2/2025, 6:16PM, changed. X E.
7/8/2025, 6:29PM, done. X E.
*/
/*
7/26/2023, 12:32PM, start.
Started by Norvel M. IV, Josiah.
Started on Ubuntu Touch using uText.
I define "X E" and "XE" ending things to mean:
"All that is near and with this me and since like my last adequate uncertainty to this me as per one might be input maybe or might not be input maybe or might be output maybe or might not be output maybe, maybe or maybe not, maybe.".
In a sentence, "A" may be lower case and if a period is after "X E" then period may be omitted from that definition.
This Rinom is intended to allow drawing in 3 or more dimensions using dimension axes on a 2 dimensional screen.
X E.
*/
// Define the input and output buffers
RWStructuredBuffer<float> points;
RWStructuredBuffer<float2> points2d;
RWStructuredBuffer<uint> shapes;
RWStructuredBuffer<uint> shapeEnds;
RWStructuredBuffer<float2> zDists;
RWStructuredBuffer<uint> drawOrder;
// Constant buffer for parameters
cbuffer ComputeParams {
    uint3 xyz;           // 3 integers for x, y, z
    uint unitSize;       // Number of floats per unit
    uint pointNumber;    // Number of points
    uint shapeNumber;    // Number of shapes
    float3 constants;   // 3 float constants
    float2 offset2d;    // 2d offsets
    uint shouldRound;   // Whether to round
    float roundWith;    // What to round with
    float precPad;      // Precision padding
    //X E
};
//X E
uniform uint step; // step is number to do to other number of it e.g. 2 to 2 or 1 to 1.
//X E
//Main shader
[shader("compute")]
[numthreads(256, 1, 1)]
void to2dMain(uint3 dispatchThreadID : SV_DispatchThreadID) {
    //Return if too much.
    if (dispatchThreadID.x>=pointNumber) {
        return;
    }
    //initialize stuff.
    int end=2*unitSize+dispatchThreadID.x*unitSize;
    int use=unitSize-1;
    float number;
    //Do not compare xyz.
    while (use==xyz[0]||use==xyz[1]||use==xyz[2]) {
        use-=1;
    }
    //Main checker loop
    while (use != -1) {
        number=points[use]+(points[end+use]-points[use])*constants[2]/(points[end+xyz[2]]-points[xyz[2]]);
        //Checks, if it can then continue true but end upon failure.
        if (number==points[unitSize+use]) {
            //in, next
            use-=1;
            while (use==xyz[0]||use==xyz[1]||use==xyz[2]) {
                use-=1;
            }
            continue;
        } else if (shouldRound==0) {
            if (round(number*roundWith)/roundWith==round(points[unitSize+use]*roundWith)/roundWith) {
                //in, next
                use-=1;
                while (use==xyz[0]||use==xyz[1]||use==xyz[2]) {
                    use-=1;
                }
                continue;
            } else if (round(number*roundWith)/roundWith==points[unitSize+use]) {
                //in, next
                use-=1;
                while (use==xyz[0]||use==xyz[1]||use==xyz[2]) {
                    use-=1;
                }
                continue;
            }
        }
        if (precPad != 0.0) {
            if ((points[unitSize+use] >= number-precPad && points[unitSize+use] <= number+precPad) || (number >= points[unitSize+use]-precPad && number <= points[unitSize+use]+precPad)) {
                //in, next
                use-=1;
                while (use==xyz[0]||use==xyz[1]||use==xyz[2]) {
                    use-=1;
                }
                continue;
            }
        }
        //X E
        break;
        //X E.
    }
    //Assign this one.
    if (use == -1) {
        //Assign numbers
        points2d[dispatchThreadID.x]=float2(constants[0]+(points[end+xyz[0]]-points[xyz[0]])*constants[2]/(points[end+xyz[2]]-points[xyz[2]]),constants[0]+(points[end+xyz[1]]-points[xyz[1]])*constants[2]/(points[end+xyz[2]]-points[xyz[2]]));
    } else {
        //Assign not a number.
        points2d[dispatchThreadID.x]=float2(0.0/0.0,0.0/0.0);
    }
    //X E
}
//X E
