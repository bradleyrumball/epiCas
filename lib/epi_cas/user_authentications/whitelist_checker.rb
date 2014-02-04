module EpiCas
  module UserAuthentications
    class WhitelistChecker < Struct.new(:raw_dn)
      USER_TYPES = {
        'ou=Staff,ou=Users,dc=sheffield,dc=ac,dc=uk'                                 => :staff,
        'ou=Honorary,ou=Staff,ou=Users,dc=sheffield,dc=ac,dc=uk'                     => :staff_honorary,
        'ou=Visiting,ou=Staff,ou=Users,dc=sheffield,dc=ac,dc=uk'                     => :staff_visiting,
        'ou=External,ou=Users,dc=sheffield,dc=ac,dc=uk'                              => :external,
        'ou=Research,ou=Postgraduates,ou=Students,ou=Users,dc=sheffield,dc=ac,dc=uk' => :student_pg_research,
        'ou=Taught,ou=Postgraduates,ou=Students,ou=Users,dc=sheffield,dc=ac,dc=uk'   => :student_pg_taught,
        'ou=Undergraduates,ou=Students,ou=Users,dc=sheffield,dc=ac,dc=uk'            => :student_undergraduate
      }
    
      def allow_authentication?
        [:staff, :staff_honorary, :staff_visiting, :external].member? type
      end
    
      def allow_creation?
        [:staff, :staff_honorary, :staff_visiting, :external].member? type
      end
    
      private
        def type
          USER_TYPES[dn]
        end
    
        def dn
          @dn ||= raw_dn[/ou=.*dc=uk/]
        end
    end
  end
end