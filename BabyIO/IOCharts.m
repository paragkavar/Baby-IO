//
//  IOCharts.m
//  BabyIO
//
//  Created by Andrew Hunzeker on 5/23/11.
//  Copyright 2011 Andrew HunzekerHesed. All rights reserved.
//

#import "IOCharts.h"





@implementation IOCharts

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*- (void)viewDidLoad {
    [super viewDidLoad];
    
    graph = [[CPXYGraph alloc] initWithFrame: self.view.bounds];
    
    CPLayerHostingView *hostingView = (CPLayerHostingView *)self.view;
    hostingView.hostedLayer = graph;
    graph.paddingLeft = 20.0;
    graph.paddingTop = 20.0;
    graph.paddingRight = 20.0;
    graph.paddingBottom = 20.0;
    
    CPXYPlotSpace *plotSpace = (CPXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.xRange = [CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(-6) 
                                                   length:CPDecimalFromFloat(12)];
    plotSpace.yRange = [CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(-5) 
                                                   length:CPDecimalFromFloat(30)];
    
    CPXYAxisSet *axisSet = (CPXYAxisSet *)graph.axisSet;
    
    CPLineStyle *lineStyle = [CPLineStyle lineStyle];
    lineStyle.lineColor = [CPColor blackColor];
    lineStyle.lineWidth = 2.0f;
    
    axisSet.xAxis.majorIntervalLength = [NSDecimalNumber decimalNumberWithString:@"5"];
    axisSet.xAxis.minorTicksPerInterval = 4;
    axisSet.xAxis.majorTickLineStyle = lineStyle;
    axisSet.xAxis.minorTickLineStyle = lineStyle;
    axisSet.xAxis.axisLineStyle = lineStyle;
    axisSet.xAxis.minorTickLength = 5.0f;
    axisSet.xAxis.majorTickLength = 7.0f;
    axisSet.xAxis.axisLabelOffset = 3.0f;
    
    axisSet.yAxis.majorIntervalLength = [NSDecimalNumber decimalNumberWithString:@"5"];
    axisSet.yAxis.minorTicksPerInterval = 4;
    axisSet.yAxis.majorTickLineStyle = lineStyle;
    axisSet.yAxis.minorTickLineStyle = lineStyle;
    axisSet.yAxis.axisLineStyle = lineStyle;
    axisSet.yAxis.minorTickLength = 5.0f;
    axisSet.yAxis.majorTickLength = 7.0f;
    axisSet.yAxis.axisLabelOffset = 3.0f;
    
    CPScatterPlot *xSquaredPlot = [[[CPScatterPlot alloc] 
                                    initWithFrame:graph.defaultPlotSpace.bounds] autorelease];
    xSquaredPlot.identifier = @"X Squared Plot";
    xSquaredPlot.dataLineStyle.lineWidth = 1.0f;
    xSquaredPlot.dataLineStyle.lineColor = [CPColor redColor];
    xSquaredPlot.dataSource = self;
    [graph addPlot:xSquaredPlot];
    
    CPPlotSymbol *greenCirclePlotSymbol = [CPPlotSymbol ellipsePlotSymbol];
    greenCirclePlotSymbol.fill = [CPFill fillWithColor:[CPColor greenColor]];
    greenCirclePlotSymbol.size = CGSizeMake(2.0, 2.0);
    xSquaredPlot.defaultPlotSymbol = greenCirclePlotSymbol;  
    
    CPScatterPlot *xInversePlot = [[[CPScatterPlot alloc] 
                                    initWithFrame:graph.defaultPlotSpace.bounds] autorelease];
    xInversePlot.identifier = @"X Inverse Plot";
    xInversePlot.dataLineStyle.lineWidth = 1.0f;
    xInversePlot.dataLineStyle.lineColor = [CPColor blueColor];
    xInversePlot.dataSource = self;
    [graph addPlot:xInversePlot];
}

-(NSUInteger)numberOfRecords {
    return 51;
}

-(NSNumber *)numberForPlot:(CPPlot *)plot field:(NSUInteger)fieldEnum  
               recordIndex:(NSUInteger)index
{
    double val = (index/5.0)-5;
    if(fieldEnum == CPScatterPlotFieldX)
    { return [NSNumber numberWithDouble:val]; }
    else
    { 
        if(plot.identifier == @"X Squared Plot")
        { return [NSNumber numberWithDouble:val*val]; }
        else
        { return [NSNumber numberWithDouble:1/val]; }
    }
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
