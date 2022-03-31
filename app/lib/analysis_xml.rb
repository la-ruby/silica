# Property Analysis Requests go out as xml
class AnalysisXml
  def initialize(project)
    @project = project
  end

  def xml
    %{
      <avmx>
        <request type="complexityprofiler" transferinfo="true" compTransferInfo="true" dataSource="mls" pdfReport="true" subjectDataSource="mlsdq" compsType="distancenozip" chartsEmbedded="true" refi="true" mlssupplementalinfo="true" marketconditions="true" avmforecast="true">
          <requestheader>
            <timestamp>0001-01-01T00:00:00</timestamp>
            <metainfo name="transactionid" value="" />
            <metainfo name="parent_sqn" value="0" />
            <account>
              <userid>#{CHART_SERVICE_USERNAME}</userid>
              <password>#{CHART_SERVICE_PASSWORD}</password>
            </account>
          </requestheader>
          <property>
            <address>
              <fulladdress>#{@project.street}</fulladdress>
              <city>#{@project.city}</city>
              <state>#{@project.state}</state>
              <zip>#{@project.zip}</zip>
            </address>
          </property>
          <searchcriteria maxdistance="2">
            <complookuprange>
            <low>0</low>
            <high>12</high>
            </complookuprange>
            <areafocus />
          </searchcriteria>
        </request>
      </avmx>
    }
  end
end
